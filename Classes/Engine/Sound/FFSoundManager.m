//
//  newSoundManager.m
//  Rocket
//
//  Created by Александр on 17.12.09.
//  Copyright 2009 Soulteam. All rights reserved.
//

#import "FFSoundManager.h"

@interface FFSoundManager (Private)


-(UInt32)audioFileSize:(AudioFileID)fileDescriptor;
-(AudioFileID)openAudioFile:(NSString*)theFilePath;
-(void)createMusicObjectWithKey:(NSString*)key;
-(BOOL)reinitialiseBGMPlayerWithURL:(NSURL*)url;
-(void)playBGM:(BOOL)once;


@end

void* MyGetOpenALAudioData(CFURLRef inFileURL, ALsizei *outDataSize, ALenum *outDataFormat, ALsizei*    outSampleRate)  //Загрузка аудио-файлов в память
{
    OSStatus                        err = noErr;    
    SInt64                            theFileLengthInFrames = 0;
    AudioStreamBasicDescription        theFileFormat;
    UInt32                            thePropertySize = sizeof(theFileFormat);
    ExtAudioFileRef                    extRef = NULL;
    void*                            theData = NULL;
    AudioStreamBasicDescription        theOutputFormat;
	
    // Open a file with ExtAudioFileOpen()
    err = ExtAudioFileOpenURL(inFileURL, &extRef);
    if(err) { printf("MyGetOpenALAudioData: ExtAudioFileOpenURL FAILED, Error = %ld\n", err); goto Exit; }
    
    // Get the audio data format
    err = ExtAudioFileGetProperty(extRef, kExtAudioFileProperty_FileDataFormat, &thePropertySize, &theFileFormat);
    if(err) { printf("MyGetOpenALAudioData: ExtAudioFileGetProperty(kExtAudioFileProperty_FileDataFormat) FAILED, Error = %ld\n", err); goto Exit; }
    if (theFileFormat.mChannelsPerFrame > 2)  { printf("MyGetOpenALAudioData - Unsupported Format, channel count is greater than stereo\n"); goto Exit;}
	
    // Set the client format to 16 bit signed integer (native-endian) data
    // Maintain the channel count and sample rate of the original source format
    theOutputFormat.mSampleRate = theFileFormat.mSampleRate;
    theOutputFormat.mChannelsPerFrame = theFileFormat.mChannelsPerFrame;
	
    theOutputFormat.mFormatID = kAudioFormatLinearPCM;
    theOutputFormat.mBytesPerPacket = 2 * theOutputFormat.mChannelsPerFrame;	
    theOutputFormat.mFramesPerPacket = 1;
    theOutputFormat.mBytesPerFrame = 2 * theOutputFormat.mChannelsPerFrame;
    theOutputFormat.mBitsPerChannel = 16;
    theOutputFormat.mFormatFlags = kAudioFormatFlagsNativeEndian | kAudioFormatFlagIsPacked | kAudioFormatFlagIsSignedInteger;
    
    // Set the desired client (output) data format
    err = ExtAudioFileSetProperty(extRef, kExtAudioFileProperty_ClientDataFormat, sizeof(theOutputFormat), &theOutputFormat);
    if(err) { printf("MyGetOpenALAudioData: ExtAudioFileSetProperty(kExtAudioFileProperty_ClientDataFormat) FAILED, Error = %ld\n", err); goto Exit; }
    
    // Get the total frame count
    thePropertySize = sizeof(theFileLengthInFrames);
    err = ExtAudioFileGetProperty(extRef, kExtAudioFileProperty_FileLengthFrames, &thePropertySize, &theFileLengthInFrames);
    if(err) { printf("MyGetOpenALAudioData: ExtAudioFileGetProperty(kExtAudioFileProperty_FileLengthFrames) FAILED, Error = %ld\n", err); goto Exit; }
    
    // Read all the data into memory
    UInt32        dataSize = theFileLengthInFrames * theOutputFormat.mBytesPerFrame;
    theData = malloc(dataSize);
    if (theData)
    {
        AudioBufferList        theDataBuffer;
        theDataBuffer.mNumberBuffers = 1;
        theDataBuffer.mBuffers[0].mDataByteSize = dataSize;
        theDataBuffer.mBuffers[0].mNumberChannels = theOutputFormat.mChannelsPerFrame;
        theDataBuffer.mBuffers[0].mData = theData;
        
        // Read the data into an AudioBufferList
        err = ExtAudioFileRead(extRef, (UInt32*)&theFileLengthInFrames, &theDataBuffer);
        if(err == noErr)
        {
            // success
            *outDataSize = (ALsizei)dataSize;
            *outDataFormat = (theOutputFormat.mChannelsPerFrame > 1) ? AL_FORMAT_STEREO16 : AL_FORMAT_MONO16;
            *outSampleRate = (ALsizei)theOutputFormat.mSampleRate;
        }
        else 
        { 
            // failure
            free (theData);
            theData = NULL; // make sure to return NULL
            printf("MyGetOpenALAudioData: ExtAudioFileRead FAILED, Error = %ld\n", err); goto Exit;
        }    
    }
    
Exit:
    // Dispose the ExtAudioFileRef, it is no longer needed
    if (extRef) ExtAudioFileDispose(extRef);
    return theData;
}


@implementation FFSoundManager

-(id)init {
	
	if (self = [super init]) {
		[self allowOtherAudio];
		
		soundLibrary = [[NSMutableDictionary alloc] init];
		queues = [[NSMutableDictionary alloc] init];
		
		alGetError();
		
		device = alcOpenDevice(NULL);
		if (alGetError() != AL_NO_ERROR) {
			
			NSLog(@"Failed opening AL device");
			device = nil;
			
		}
		
		if (device) {
			context = alcCreateContext(device, NULL);
			alcMakeContextCurrent(context);
		}
	}
	
	return self;
}

-(void)allowOtherAudio {
	UInt32 size=sizeof(UInt32);
	AVAudioSession* session = [AVAudioSession sharedInstance];
	AudioSessionGetProperty(kAudioSessionProperty_OtherAudioIsPlaying, &size, &otherAudioIsPlaying);
	
	if (otherAudioIsPlaying) {
		[session setCategory:AVAudioSessionCategoryAmbient error:nil];
	} else {
		[session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
	}

}

- (void) preloadSound:(NSString*)theSoundKey fileName:(NSString*)theFileName fileExt:(NSString*)theFileExt  {
	

	NSString *filePath = [[NSBundle mainBundle] pathForResource:theFileName ofType:theFileExt];
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:filePath];
	
	NSUInteger bufferID;
	alGenBuffers(1, &bufferID);
	
	ALenum outDataFormat;
	ALsizei rate = 0;
	ALsizei mySize;
	unsigned char *unpackedData;
	
	unpackedData = MyGetOpenALAudioData(url, &mySize, &outDataFormat, &rate);
	
	alBufferData(bufferID, outDataFormat, unpackedData, mySize, rate);

	[soundLibrary setObject:[NSNumber numberWithUnsignedInt:bufferID] forKey:theSoundKey];
	
	if(unpackedData) {
		free(unpackedData);
		unpackedData = NULL;
	}
}

/*
 Used to load an audiofile from the file path which is provided.
 */
- (AudioFileID) openAudioFile:(NSString*)theFilePath {
	
	AudioFileID outAFID;
	// Create an NSURL which will be used to load the file.  This is slightly easier
	// than using a CFURLRef
	NSURL *afUrl = [NSURL fileURLWithPath:theFilePath];
	
	// Open the audio file provided
	OSStatus result = AudioFileOpenURL((CFURLRef)afUrl, kAudioFileReadPermission, 0, &outAFID);
	
	if(result != 0)	{
		NSLog(@"ERROR SoundEngine: Canno-(UInt32)audioFilePacketSize:(AudioFileID)fileDescriptort open file: %@", theFilePath);
		return nil;
	}
	
	return outAFID;
}

- (UInt32) audioFileSize:(AudioFileID)fileDescriptor {
	UInt64 outDataSize = 0;
	UInt32 thePropSize = sizeof(UInt64);
	OSStatus result = AudioFileGetProperty(fileDescriptor, kAudioFilePropertyAudioDataByteCount, &thePropSize, &outDataSize);
	if(result != 0)	NSLog(@"ERROR: cannot get file size");
	return (UInt32)outDataSize;
}

- (void) createMusicObjectWithKey:(NSString*)key {
	
	alGetError();
	ALuint sourceID;
	alGenSources(1, &sourceID);
	
	FFAudioQueue* music = [[FFAudioQueue alloc] initWithSourceID: sourceID];
	
	[queues setObject:[music autorelease] forKey:key]; 
	
	if (alGetError() != AL_NO_ERROR) {
		NSLog(@"Failed to generate source");
		return;
	}
	
}

-(void) addSound:(NSString*)sound toQueue:(NSString*)queue {
	
	BOOL contains = ([queues objectForKey:queue] != nil);
	
	if (!contains) {
		[self createMusicObjectWithKey:queue];
	}
	
	NSNumber* bufferIDVal = [soundLibrary objectForKey: sound];
	
	FFAudioQueue* music = [queues objectForKey:queue];
	
	[queues removeObjectForKey:queue];
	[music.buffers addObject:bufferIDVal];
	[queues setObject:music forKey:queue];
	
}

-(FFAudioQueue*)getQueue:(NSString*) queueKey {
	
	FFAudioQueue* queue = [queues objectForKey:queueKey];
	
	return queue;
	
}


-(FFSound*)getSound:(NSString*)soundKey {
	
	alGetError();
	ALuint sourceID;
	alGenSources(1, &sourceID);
	
	if (alGetError() != AL_NO_ERROR) {
		NSLog(@"Failed to generate sources");
		return nil;
	}
	
	NSNumber* numVal = [soundLibrary objectForKey:soundKey];
	if(numVal == nil) return 0;
	NSUInteger bufferID = [numVal unsignedIntValue];
	
	alSourcei(sourceID, AL_BUFFER, bufferID);
	
	FFSound* sound = [[FFSound alloc] initWithSourceID:sourceID];
	
	return [sound autorelease]; 
}

-(BOOL)playBackgroundMusic:(NSString*)fileName once:(BOOL)onceOrManyTimes {
	
	if (otherAudioIsPlaying) {
		return YES;
	}

	NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] ofType:[fileName pathExtension]];
	NSURL* url = [NSURL fileURLWithPath:filePath];
	
	if (BGMPlayer) {
		if ([[BGMPlayer.url path] caseInsensitiveCompare:filePath] == NSOrderedSame) {
			if (!BGMPlayer.playing) {
				[self playBGM:onceOrManyTimes];
				return YES;
			} else {
				return NO;
			}

		} else {
			[BGMPlayer release];
			BGMPlayer = nil;
			if ([self reinitialiseBGMPlayerWithURL:url]) {
				[self playBGM:onceOrManyTimes];
				return YES;
			} else {
				NSLog(@"error playing sound");
				return NO;
			} 
		}

	} else {
		if ([self reinitialiseBGMPlayerWithURL:url]) {
			[self playBGM:onceOrManyTimes];
			return YES;
		} else {
			NSLog(@"error playing sound");
			return NO;
		} 
	}
	
}

-(void)playBGM:(BOOL)once {

	if (BGMPlayer) {
		if (once) {
			BGMPlayer.numberOfLoops = 0;
		} else {
			BGMPlayer.numberOfLoops = -1;
		}
		[self rewindBGM];
		[BGMPlayer play];
	}
	
}

-(void)stopBGM {

	if (BGMPlayer && BGMPlayer.playing) {
		[BGMPlayer stop];
	}
	
}

-(BOOL)BGMStopped {
	return !BGMPlayer.playing;
	
	return YES;
}

-(void)rewindBGM {
	
	[BGMPlayer setCurrentTime:0];
	
}

-(BOOL)reinitialiseBGMPlayerWithURL:(NSURL*)url {
	
	NSError* error;
	BGMPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	
	if (error != nil) {
		NSLog(@"Error initialising background music player");
		return NO;
	} else {
		return YES; //все хорошо
	}

	
}

-(void) dealloc {
	
	[soundLibrary release];
	[queues release];
	
	if (BGMPlayer) {
		[BGMPlayer stop];
		[BGMPlayer release];
	}
	
	NSEnumerator *enumerator = [soundLibrary keyEnumerator];
	id key;
	while ((key = [enumerator nextObject])) {
		NSNumber *bufferIDVal = [soundLibrary objectForKey:key];
		NSUInteger bufferID = [bufferIDVal unsignedIntValue];
		alDeleteBuffers(1, &bufferID);		
	}
	
	alcMakeContextCurrent(NULL);
	alcDestroyContext(context);
	alcCloseDevice(device);
	
	[super dealloc];
	
}


@end



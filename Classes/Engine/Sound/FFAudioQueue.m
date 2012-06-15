//
//  Music.m
//  Santa
//
//  Created by Александр on 20.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FFAudioQueue.h"


@implementation FFAudioQueue

@synthesize buffers;


-(id)initWithSourceID:(ALuint)ID {
	
	if (self = [super init]) {
		
		buffers = [[NSMutableArray alloc] init];
		sourceID = ID;
		
	}
	
	return self;
}

-(void) play {
	
	ALint queued;
	
	alGetSourcei(sourceID, AL_BUFFERS_QUEUED, &queued);
	if (0 == queued) {
		
		for (NSNumber* number in buffers) {
			
			NSUInteger value = [number unsignedIntValue];
			alSourceQueueBuffers(sourceID, 1, &value);
			
		}
		
	}
	
	alSourcePlay(sourceID);
	
}

-(void) update {
	
	ALint processed;
	ALint queued;
	
	alGetSourcei(sourceID, AL_BUFFERS_QUEUED, &queued);
	alGetSourcei(sourceID, AL_BUFFERS_PROCESSED, &processed);
	
	if (processed == queued) {
		for (NSNumber* number in buffers) {
			
			NSUInteger value = [number unsignedIntValue];
			alSourceUnqueueBuffers(sourceID, 1, &value);
			
		}
		
		for (NSNumber* number in buffers) {
			
			NSUInteger value = [number unsignedIntValue];
			alSourceQueueBuffers(sourceID, 1, &value);
			
		}
		
		[self play];
	}
	
}

-(void) dealloc {
	
	[buffers release];
	[super dealloc];
	
}

@end


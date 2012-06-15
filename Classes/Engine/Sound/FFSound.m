//
//  Sound.m
//  Rocket
//
//  Created by Александр on 17.12.09.
//  Copyright 2009 Soulteam. All rights reserved.
//

#import "FFSound.h"

@implementation FFSound


-(id)initWithSourceID:(ALuint)ID {
	
	if (self = [super init]) {
		
		sourceID = ID;
	}
	
	return self;
}


-(void)play {
	ALint state;
	alGetSourcei(sourceID, AL_SOURCE_STATE, &state);
	if (state != AL_PLAYING) {
		alSourcePlay(sourceID);
	}
}

-(void)stop {
	
	alSourceStop(sourceID);
	
}

-(void)loop {
	
	alSourcei(sourceID, AL_LOOPING, AL_TRUE);
	alSourcePlay(sourceID);
	
}

-(BOOL)stopped {
	
	ALint state;
	alGetSourcei(sourceID, AL_SOURCE_STATE, &state);
	
	return state == AL_STOPPED;
	
}

-(void) dealloc {
	
	alDeleteSources(1, &sourceID);
	[super dealloc];
	
}

@end
//
//  PlaySound.m
//  MathWars
//
//  Created by SwinX on 16.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "PlaySound.h"
#import "FFGame.h"


@implementation PlaySound

+(PlaySound*)named:(NSString*)name {
	
	return [[[PlaySound alloc] initWithSoundName:name] autorelease];
	
}

-(id)initWithSoundName:(NSString*)name {
	
	if (self = [super init]) {
		sound = [[[FFGame sharedGame].soundManager getSound:name] retain];
	}
	return self;
}

-(void)start {
	[sound play];
}

-(void)doForTime:(CFTimeInterval)time {	
}

-(BOOL)finished {
	return [sound stopped];
}

-(void)dealloc {
	[sound release];
	[super dealloc];
}
@end

//
//  Animate.m
//  MathWars
//
//  Created by SwinX on 08.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Play.h"
#import "FFGame.h"


@implementation Play

+(id)frames:(NSArray*)_frames ofSprite:(FFSprite*)_sprite withDelay:(CFTimeInterval)_delay; {
	return [[[Play alloc] initWithSprite:_sprite andFrames:_frames andDelay:_delay] autorelease];	
}

-(id)initWithSprite:(FFSprite*)_sprite andFrames:(NSArray*)_frames andDelay:(CFTimeInterval)_delay; {
	
	if (self = [super init]) {
		frames = [_frames retain];
		sprite = [_sprite retain];
		currentSprite = 0;
		elapsed = delay = _delay;
					
	}
	return self;
}

-(void)start {
	sprite.texture = [[FFGame sharedGame].renderer loadTexture:[frames objectAtIndex:0]];
}

-(void)doForTime:(CFTimeInterval)time {
	
	elapsed -= time;
	if (elapsed < 0) {
		elapsed = delay;
		currentSprite++;
		if (currentSprite <= frames.count -1) {
			sprite.texture = [[FFGame sharedGame].renderer loadTexture:[frames objectAtIndex:currentSprite]]; 
		}
		
	}
	
}

-(BOOL)finished {
	return currentSprite == frames.count;
}

-(void)dealloc {
	[sprite release];
	[frames release];	
	[super dealloc];	
}

@end

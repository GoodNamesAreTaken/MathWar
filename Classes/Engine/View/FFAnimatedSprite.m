//
//  AnimatedSprite.m
//  Santa
//
//  Created by Inf on 17.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FFGame.h"
#import "FFAnimatedSprite.h"
#import "Trigger.h"

@interface FFAnimatedSprite(Private)

-(void)changeFrame:(FFTimer*)timer;

@end



@implementation FFAnimatedSprite

-(id)init {
	
	if (self = [super init]) {
		frames = [[NSMutableArray alloc] init];
		paused = NO;
	}
	return self;
}

-(id)initWithArray:(NSArray*)array {
	if (self = [super initWithTextureNamed:[array objectAtIndex:0]]) {
		paused = NO;
		frames = [[NSMutableArray alloc] init];
		//[frames addObject:[[FFGame sharedGame].renderer loadTexture:[array objectAtIndex:0]]];
		
		for (int i=0; i<array.count; i++) {
			[frames addObject:[[FFGame sharedGame].renderer loadTexture:[array objectAtIndex:i]]];
		}
	}
	return self;
}

-(id)initWithFrameSequence:(NSString*)firstTexture, ... {
	if (self = [super initWithTextureNamed:firstTexture]) {
		paused = NO;
		frames = [[NSMutableArray alloc] init];
		[frames addObject:[[FFGame sharedGame].renderer loadTexture:firstTexture]];
		
		va_list args;
		va_start(args, firstTexture);
		
		NSString* textureName = va_arg(args, NSString*);
		while (textureName != nil) {
			[frames addObject:[[FFGame sharedGame].renderer loadTexture:textureName]];
			textureName = va_arg(args, NSString*);
		}
		va_end(args);
	}
	return self;
}

-(void)addSpritesFromArray:(NSArray*)pictureNames {
	
	[frames removeAllObjects];
	for (NSString* pictureName in pictureNames) {
		[frames addObject:[[FFGame sharedGame].renderer loadTexture:pictureName]];
	}
	self.texture = [frames objectAtIndex:0];
}

-(void)playFramesFrom:(uint32_t)start to:(uint32_t)end withDelay:(float)_delay {
	self.texture = [frames objectAtIndex:start];
	startFrame = start;
	endFrame = end;
	delay = _delay;
	[self stop];
	
	animationTimer = [[[FFGame sharedGame].timerManager getTimerWithInterval:delay andSingleUse:NO] retain];
	[animationTimer.action addHandler:self andAction:@selector(changeFrame:)];
}

-(void)changeFrame:(FFTimer*)timer {
	
	BOOL turnedOver = NO;
	
	if (!paused) {
		frame++;
		
		if (frame > endFrame) {
			frame = startFrame;
			turnedOver = YES;
		}
		
		self.texture = [frames objectAtIndex:frame];
	}
	
	if (turnedOver && onSpritesTurnedOver) {
		[[FFGame sharedGame].actionManager addAction:[Trigger event:onSpritesTurnedOver]];
	}
	
}

-(void)pause {
	paused = YES;
}

-(void)play {
	paused = NO;
}

-(void)stop {
	[animationTimer stop];
	[animationTimer release];
	animationTimer = nil;
}

-(int)lastFrame {
	return frames.count-1;
}

-(void)dealloc {
	[self stop];
	[frames release];
	
	if (onSpritesTurnedOver) {
		[onSpritesTurnedOver release];
	}
	
	[super dealloc];
}

@end

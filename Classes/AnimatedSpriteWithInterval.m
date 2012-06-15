//
//  DelayedAnimatedSprite.m
//  MathWars
//
//  Created by SwinX on 08.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "AnimatedSpriteWithInterval.h"
#import "FFGame.h"

#define MAX_DELAY_BETWEEN_ANIMATIONS 7

@implementation AnimatedSpriteWithInterval

-(id)initWithFrameNames:(NSArray*)names {
	if (self = [super initWithArray:names]) {
		onSpritesTurnedOver = [[FFEvent event] retain];
		[onSpritesTurnedOver addHandler:self andAction:@selector(spritesTurnedOver)];
	}
	return self;
}

-(void)spritesTurnedOver {
	[self stop];
	interval = arc4random()%MAX_DELAY_BETWEEN_ANIMATIONS + 0.5f;
	intervalTimer = [[FFGame sharedGame].timerManager getTimerWithInterval:interval andSingleUse:YES];
	[intervalTimer.action addHandler:self andAction:@selector(intervalPassed)];
}

-(void)intervalPassed {
	[self playFramesFrom:0 to:frames.count-1 withDelay:delay];
}

-(void)dealloc {
	[super dealloc];
}

@end

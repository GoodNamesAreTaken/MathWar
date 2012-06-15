//
//  BGSoundSheduler.m
//  MathWars
//
//  Created by SwinX on 07.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "BGSoundSheduler.h"
#import "FFGame.h"
#import "PlaySound.h"
#import "Call.h"
#import "FFActionSequence.h"
#import "FFTimer.h"
#import "GameUI.h"

#define RANDOM_INTERVAL arc4random()%10 + 5

@interface BGSoundSheduler(Private)

-(void)getInterval;

@end


@implementation BGSoundSheduler

-(void)addedToGame {
	[self getInterval];	
}

-(void)playSound {
	
	if ([[GameUI sharedUI].lock hasActiveCombat]) {
		[self getInterval];
	} else {
		PlaySound* play;
		
		int rand = arc4random() % 2;
		switch (rand) {
			case 0:
				play = [PlaySound named:@"windHowl1"];
				break;
			case 1:
				play = [PlaySound named:@"windHowl2"];
				break;

		}
		
		[[FFGame sharedGame].actionManager addAction:[[[FFActionSequence alloc] initWithActions:play, [Call selector:@selector(getInterval) ofObject:self], nil] autorelease]];
	}
	
}

-(void)getInterval {
	FFTimer* timer = [[FFGame sharedGame].timerManager getTimerWithInterval:RANDOM_INTERVAL andSingleUse:YES];
	[timer.action addHandler:self andAction:@selector(playSound)];
}

@end

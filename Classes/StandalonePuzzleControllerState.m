//
//  StandalonePuzzleControllerState.m
//  MathWars
//
//  Created by Inf on 05.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "GameUI.h"
#import "FFGame.h"
#import "PuzzleController.h"
#import "StandalonePuzzleControllerState.h"
#import "Player.h"
#import "PlaySound.h"


@implementation StandalonePuzzleControllerState

+(id)state {
	return [[[StandalonePuzzleControllerState alloc] init] autorelease];
}

-(void)appear:(PuzzleController *)controller {
	[GameUI sharedUI].lock.hasActivePuzzle = YES;
}

-(void)delayedRemove {

	[GameUI sharedUI].lock.hasActivePuzzle = NO;
	[[FFGame sharedGame] removeController:targetController];
	
	[targetController release];
	targetController = nil;
	[[GameUI sharedUI].textPanel showMovesCount];
	
}

-(void)disapear:(PuzzleController *)controller {
	if (controller.model.solved) {
		[[FFGame sharedGame].actionManager addAction: [PlaySound named:@"puzzleWin"]];
	} else {
		[[FFGame sharedGame].actionManager addAction: [PlaySound named:@"puzzleFail"]];
	}
	timer = [[FFGame sharedGame].timerManager getTimerWithInterval:3.0 andSingleUse:YES];
	targetController = [controller retain];
	[timer.action addHandler:self andAction:@selector(delayedRemove)];
}

-(void)forceDisapear:(PuzzleController *)controller {
	targetController = [controller retain];
	if (timer) {
		[timer stop];
	}
	[self delayedRemove];
}

@end

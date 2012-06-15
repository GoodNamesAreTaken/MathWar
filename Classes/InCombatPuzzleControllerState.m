//
//  InCombatPuzzleControllerState.m
//  MathWars
//
//  Created by Inf on 05.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "PuzzleController.h"
#import "InCombatPuzzleControllerState.h"
#import "GameUI.h"
#import "FFGame.h"

@implementation InCombatPuzzleControllerState

+(id)state {
	return [[[InCombatPuzzleControllerState alloc] init] autorelease];
}

-(void)appear:(PuzzleController *)controller {
	[GameUI sharedUI].lock.hasActivePuzzle = YES;
}

-(void)disapear:(PuzzleController *)controller {
	[GameUI sharedUI].lock.hasActivePuzzle = NO;
	[[FFGame sharedGame] removeController:controller];
}

@end

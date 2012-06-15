//
//  HumanPlayer.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "HumanPuzzle.h"
#import "HumanPlayer.h"
#import "GameObserver.h"
#import "PlayerObserver.h"

#import "ExcersizePuzzle.h"
#import "ComparePuzzle.h"
#import "SequencePuzzle.h"

@implementation HumanPlayer
@synthesize activeUnit, 
puzzleCreationDelegate;

-(void)endTurn {
	self.activeUnit = nil;
	[super endTurn];

}

-(Puzzle*)createPuzzleOfDifficulty:(uint32_t)difficulty withDelegate:(id<PuzzleObserver>)puzzleDelegate {
	Puzzle* puzzle;//  = [HumanPuzzle puzzleWithDifficulty:difficulty andCaller:puzzleDelegate];
	
	switch (difficulty) {
		case EASY_DIFFICULTY:
			puzzle = [[ExcersizePuzzle alloc] initWithDelegate:puzzleDelegate andDifficulty:difficulty];
			break;
		case NORMAL_DIFFICULTY:
			puzzle = [[ComparePuzzle alloc] initWithDelegate:puzzleDelegate andDifficulty:difficulty];
			break;
		default:
			puzzle = [[SequencePuzzle alloc] initWithDelegate:puzzleDelegate andDifficulty:difficulty];
	}
	
	[puzzleCreationDelegate puzzleCreated:puzzle];
	
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(player:createdPuzzle:)]) {
			[observer player:self createdPuzzle:puzzle];
		}
	}
	return [puzzle autorelease];
}

-(void)setActiveUnit:(Unit *)newUnit {

	[activeUnit cancelSelection];
	activeUnit = newUnit;
	[activeUnit select];
	
	/*if (!activeUnit) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"UnitDeselected" object:activeUnit];
	}*/

	

}

@end

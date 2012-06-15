//
//  TutorialAI.m
//  MathWars
//
//  Created by Inf on 28.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "TutorialAI.h"
#import "AIPuzzle.h"

@implementation TutorialAI

-(id)init {
	if (self = [super init]) {
		puzzleAnswerStrategy = [[DelayedAnswerStrategy alloc] init];
	}
	return self;
}

-(void)startTurn {
	[super startTurn];
	[self endTurn];
}

-(void)assignUnit:(Unit *)unit {
	[super assignUnit:unit];
	if (unit.type == MWUnitBaseProtector) {
		unit.health = 5;
		unit.attack = 1;
	}
}

-(void)startCombat:(Combat *)combat {
	[self readyToNextRoundOfCombat:combat];
}

-(void)finishCombatRound:(Combat *)combat {
	[self readyToNextRoundOfCombat:combat];
}

-(Puzzle*)createPuzzleOfDifficulty:(uint32_t)difficulty withDelegate:(id<PuzzleObserver>)delegate {
	AIPuzzle* puzzle = [[AIPuzzle alloc] initWithDelegate:delegate andDifficulty:difficulty];
	[puzzleAnswerStrategy answerPuzzle:puzzle];
	return [puzzle autorelease];
}

-(void)dealloc {
	[puzzleAnswerStrategy release];
	[super dealloc];
}

@end

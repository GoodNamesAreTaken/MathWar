//
//  Obstacle.m
//  MathWars
//
//  Created by SwinX on 09.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Obstacle.h"
#import "Player.h"

@implementation Obstacle

-(id)init {
	return [self initWithPuzzleDifficulty:EASY_DIFFICULTY];
}

-(id)initWithPuzzleDifficulty:(uint8_t)difficulty {
	if (self = [super init]) {
		puzzleDifficulty = difficulty;
	}
	return self;
}

-(void)unitEnteredEmptyCell:(Unit *)unit {
	candiadate = [unit retain];
	[unit.owner createPuzzleOfDifficulty:puzzleDifficulty withDelegate:self];
}

-(void)negativeEffectOn:(Unit*)unit {
}

-(void)positiveEffectOn:(Unit*)unit {
	[unit becomeGuardianOf:self];
}

-(void)puzzleWasFailed:(Puzzle *)puzzle {
	[self negativeEffectOn:candiadate];
	[candiadate release];
	candiadate = nil;
}

-(void)puzzleWasSolved:(Puzzle *)puzzle {
	[self positiveEffectOn:candiadate];
	[candiadate release];
	candiadate = nil;
}

-(void)dealloc {
	[candiadate release];
	[super dealloc];
}

@end

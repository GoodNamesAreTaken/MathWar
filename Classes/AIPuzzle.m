//
//  AIPuzzle.m
//  MathWars
//
//  Created by SwinX on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "AIPuzzle.h"
#import "FFGame.h"
#import "StatisticManager.h"


@implementation AIPuzzle
@synthesize thinkTime;

-(id)initWithDelegate:(id<PuzzleObserver>)puzzleDelegate andDifficulty:(int)puzzleDifficulty { 
	
	if (self = [super initWithDelegate:puzzleDelegate andDifficulty:puzzleDifficulty]) {
		thinkTime = ([[StatisticManager manager] getAnswerTime] * difficulty) - 0.8f;
		rightAnswerChance = arc4random() % 100;
	}
	return self;
}

-(void)trySolvePuzzle {
	
	if (rightAnswerChance > -1) { //TODO: сделать более сложную формулу расчета выйгрыша AI
		[self success];
	} else {
		[self fail];
	}	
}

-(void)dealloc {
	[super dealloc];
}
	

@end

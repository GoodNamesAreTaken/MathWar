//
//  DelayedAnswerStrategy.m
//  MathWars
//
//  Created by Inf on 05.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFGame.h"
#import "DelayedAnswerStrategy.h"


@implementation DelayedAnswerStrategy

-(void)answerPuzzle:(AIPuzzle *)puzzle {
	
	float interval = 3.0f + arc4random() % 2;
	
	[timer stop];
	[timer release];
	timer = nil;
	
	[puzzleToAnswer release];
	puzzleToAnswer = nil;
	
	puzzleToAnswer = [puzzle retain];

	[puzzleToAnswer addObserver:self];
	timer = [[[FFGame sharedGame].timerManager getTimerWithInterval:interval andSingleUse:YES] retain];
	[timer.action addHandler:self andAction:@selector(delayedAnswer)];
}

-(void)delayedAnswer {
	[timer release];
	timer = nil;
	[puzzleToAnswer trySolvePuzzle];
}

-(void)puzzleWasSolved:(Puzzle *)puzzle {
	[puzzleToAnswer release];
	puzzleToAnswer = nil;
}

-(void)puzzleWasFailed:(Puzzle *)puzzle {
	
	if (puzzle == puzzleToAnswer) {
		[timer stop];
		[timer release];
		timer = nil;
	}
	[puzzleToAnswer release];
	puzzleToAnswer = nil;
}

-(void)dealloc {
	[puzzleToAnswer release];
	[super dealloc];
}

@end

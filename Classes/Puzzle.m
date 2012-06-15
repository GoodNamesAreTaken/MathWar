//
//  Puzzle.m
//  MathWars
//
//  Created by SwinX on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Puzzle.h"


@implementation Puzzle
@synthesize difficulty;

-(id)initWithDelegate:(id<PuzzleObserver>) delegate andDifficulty:(int)puzzleDifficulty; {

	if (self = [super init]) {
		difficulty = puzzleDifficulty;
		observers = [[NSMutableArray arrayWithObject:[NSValue valueWithNonretainedObject:delegate]] retain];
		state = PSUnanswered;
	}
	return self;
	
}

-(void)addObserver:(id<PuzzleObserver>)observer {
	
	[observers addObject:[NSValue valueWithNonretainedObject:observer]];
	
}

-(void)fail {
	@synchronized(self) {
		if (state == PSUnanswered) {
			state = PSFailed;
			for (NSValue* observer in observers) {
				[[observer nonretainedObjectValue] puzzleWasFailed:self];
			}
		}
	}
}

-(void)success {
	@synchronized(self) {
		if (state == PSUnanswered) {
			state = PSSolved;
			for (NSValue* observer in observers) {
				[[observer nonretainedObjectValue] puzzleWasSolved:self];
			}
		}
	}
}

-(id<PuzzleObserver>) firstObserver {
	return [observers objectAtIndex:0];
}

-(BOOL)solved {
	return state == PSSolved;
}

-(BOOL)failed {
	return state == PSFailed;
}

-(BOOL)answered {
	return state != PSUnanswered;
}

-(void)dealloc {
	[observers release];
	[super dealloc];
	
}

@end

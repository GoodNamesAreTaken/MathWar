//
//  ComparePuzzle.m
//  MathWars
//
//  Created by Inf on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "ComparePuzzle.h"


@implementation ComparePuzzle

-(id)initWithDelegate:(id<PuzzleObserver>)puzzleCaller andDifficulty:(int)puzzleDifficulty {
	if (self = [super initWithDelegate:puzzleCaller andDifficulty:puzzleDifficulty]) {
		description = @"Compare";
		
		left = [[MathExpression alloc] init];
		right = [[MathExpression alloc] init];
		
		if (left.result > right.result) {
			result = MWGreater;
		} else if (left.result < right.result) {
			result = MWLesser;
		} else {
			result = MWEqual;
		}

	}
	return self;
			
}

-(BOOL)submitAnswer:(MWCompareResult)answer {
	if (answer == result) {
		[self success];
		return YES;
	} else {
		[self fail];
		return NO;
	}
}

-(int)rightAnswer {
	return result;
}

-(NSString*)taskString {
	return [NSString stringWithFormat:@"%@ and %@", left.stringRepresentation, right.stringRepresentation];
}

-(NSString*)answerString {
	switch (result) {
		case MWGreater:
			return [NSString stringWithFormat:@"%@ > %@", left.stringRepresentation, right.stringRepresentation];
		case MWLesser:
			return [NSString stringWithFormat:@"%@ < %@", left.stringRepresentation, right.stringRepresentation];
		default:
			return [NSString stringWithFormat:@"%@ = %@", left.stringRepresentation, right.stringRepresentation];
	}
}

-(void)dealloc {
	[left release];
	[right release];
	[super dealloc];
}

@end

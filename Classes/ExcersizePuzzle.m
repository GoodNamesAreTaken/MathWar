//
//  ExcersizePuzzle.m
//  MathWars
//
//  Created by SwinX on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "ExcersizePuzzle.h"


@implementation ExcersizePuzzle
@synthesize excersize = expression;

-(id)initWithDelegate:(id<PuzzleObserver>)puzzleCaller andDifficulty:(int)puzzleDifficulty {
	
	if (self = [super initWithDelegate:puzzleCaller andDifficulty:puzzleDifficulty]) {
		description = @"Give the answer";
		expression = [[MathExpression alloc] init];
	}
	return self;
}

-(NSString*)taskString {
	return [expression.stringRepresentation stringByAppendingString:@" ="];
}

-(NSString*)answerString {
	return [expression.stringRepresentation stringByAppendingString:[NSString stringWithFormat:@" = %d", expression.result]];
}

-(int)rightAnswer {
	return expression.result;
}

-(BOOL)submitAnswer:(int)answer {
	if (answer == expression.result) {
		[self success];
		return YES;
	} else {
		[self fail];
		return NO;
	}
	
}

-(void)dealloc {
	[expression release];
	[super dealloc];	
	
}

@end

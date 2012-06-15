//
//  SequencePuzzle.m
//  MathWars
//
//  Created by Inf on 23.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "SequencePuzzle.h"
#import "ArithmeticSequenceGenerator.h"
#import "GeometricSequenceGenerator.h"

#define SEQUENCE_LENGTH 5
#define GENERATORS_COUNT 2

@implementation SequencePuzzle

-(id)initWithDelegate:(id<PuzzleObserver>)puzzleCaller andDifficulty:(int)puzzleDifficulty {
	if (self = [super initWithDelegate:puzzleCaller andDifficulty:puzzleDifficulty]) {
		
		id<SequenceGenerator> generators[GENERATORS_COUNT] = {
			[ArithmeticSequenceGenerator generator],
			[GeometricSequenceGenerator generator]
		};
		description = @"What number is missing?";
		
		sequence = [[generators[arc4random() % GENERATORS_COUNT] createSequenceOfLength:SEQUENCE_LENGTH] retain];
		missingIndex = arc4random() % SEQUENCE_LENGTH;
	}
	return self;
}

-(BOOL)submitAnswer:(int32_t)answer {
	if (answer == [[sequence objectAtIndex:missingIndex] intValue]) {
		[self success];
		return YES;
	} else {
		[self fail];
		return NO;
	}
}

-(NSString*)answerString {
	if (sequence.count == 0) {
		return @"";
	}

	NSMutableString* answer = [NSMutableString stringWithFormat:@"%@", [sequence objectAtIndex:0]];
	for (int i=1; i<sequence.count; i++) {
		[answer appendFormat:@" %@", [sequence objectAtIndex:i]];
	}
	return answer;
}

-(NSString*) taskString {
	if (sequence.count == 0) {
		return @"";
	}
	
	NSMutableString* task;
	if (missingIndex == 0) {
		task = [NSMutableString stringWithString:@"?"];
	} else {
		task = [NSMutableString stringWithFormat:@"%@", [sequence objectAtIndex:0]];
	}
	
	for (int i=1; i<sequence.count; i++) {
		if (i == missingIndex) {
			[task appendString:@" ?"];
		} else {
			[task appendFormat:@" %@", [sequence objectAtIndex:i]];
		}
	}
	return task;
}

-(int)rightAnswer {
	return [[sequence objectAtIndex:missingIndex] intValue];
}

-(void)dealloc {
	[sequence release];
	[super dealloc];
}

@end

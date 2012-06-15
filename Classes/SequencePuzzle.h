//
//  SequencePuzzle.h
//  MathWars
//
//  Created by Inf on 23.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "HumanPuzzle.h"


@interface SequencePuzzle : HumanPuzzle {
	NSArray* sequence;
	uint32_t missingIndex;
}

@property(readonly) NSString* taskString;
@property(readonly) NSString* answerString;
@property(readonly) int rightAnswer;

-(BOOL)submitAnswer:(int32_t)answer;

@end

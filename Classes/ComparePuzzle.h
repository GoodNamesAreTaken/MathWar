//
//  ComparePuzzle.h
//  MathWars
//
//  Created by Inf on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "HumanPuzzle.h"
#import "MathExpression.h"

typedef enum _MWCompareResult {
    MWLesser,
	MWEqual,
    MWGreater,
}MWCompareResult;

@interface ComparePuzzle : HumanPuzzle {
	MathExpression* left;
	MathExpression* right;
	MWCompareResult result;
}

@property(readonly) NSString* taskString;
@property(readonly) NSString* answerString;

-(BOOL)submitAnswer:(MWCompareResult)answer;

@end

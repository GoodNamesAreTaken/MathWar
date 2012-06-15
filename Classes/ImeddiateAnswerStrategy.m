//
//  ImeddiateAnswerStrategy.m
//  MathWars
//
//  Created by Inf on 05.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "ImeddiateAnswerStrategy.h"


@implementation ImeddiateAnswerStrategy

-(void)answerPuzzle:(AIPuzzle*)puzzle {
	[puzzle trySolvePuzzle];
}

@end

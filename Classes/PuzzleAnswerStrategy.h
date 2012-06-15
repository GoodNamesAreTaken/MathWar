//
//  PuzzleAnswerStrategy.h
//  MathWars
//
//  Created by Inf on 05.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "AIPuzzle.h"

/**
 Стратегия ответов на паззлы для AI-игрока
 */
@protocol PuzzleAnswerStrategy

/**
 Решить заданный паззл
 @param Puzzle паззл
 */
-(void)answerPuzzle:(AIPuzzle*)puzzle;

@end

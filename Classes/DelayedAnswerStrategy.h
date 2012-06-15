//
//  DelayedAnswerStrategy.h
//  MathWars
//
//  Created by Inf on 05.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFTimer.h"
#import "PuzzleAnswerStrategy.h"

/**
 Стратегия ответа на паззл с задержкой
 
 Используется AI во время боя
 */
@interface DelayedAnswerStrategy : NSObject<PuzzleAnswerStrategy, PuzzleObserver> {
	FFTimer* timer;
	AIPuzzle* puzzleToAnswer;
}

/**
 Отложенный ответ на паззл
 */
-(void)delayedAnswer;
@end

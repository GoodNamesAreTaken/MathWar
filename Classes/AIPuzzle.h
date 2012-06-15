//
//  AIPuzzle.h
//  MathWars
//
//  Created by SwinX on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Puzzle.h"
#import "FFTimer.h"

/**
 Паззл для AI-игрока
 
 Решает паззл с определенной вероятностью
 */
@interface AIPuzzle : Puzzle {

	float thinkTime;
	int rightAnswerChance;
 	
}

/**
 Время, через которое AI-игрок даст ответ
 */
@property(readonly) float thinkTime;

/**
 Решает паззл с определенной вероятностью
 */
-(void)trySolvePuzzle;

@end

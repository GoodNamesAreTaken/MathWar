//
//  ExcersizePuzzle.h
//  MathWars
//
//  Created by SwinX on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "HumanPuzzle.h"
#import "MathExpression.h"


/**
 Паззл "Задача"
 
 Представляет из себя простой пример на одно из четырех базовых арифметических действий
 */
@interface ExcersizePuzzle : HumanPuzzle {

	MathExpression* expression;
}

@property(readonly) MathExpression* excersize;

/**
 Дает ответ на задачу
 
 @param ответ пользователя
 @returns YES, если задача решена верно
 */
-(BOOL)submitAnswer:(int)answer;

-(int)rightAnswer;

@end

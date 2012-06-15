//
//  HumanPuzzle.h
//  MathWars
//
//  Created by SwinX on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Puzzle.h"

/**
 Паззл, решаемый человеком
 */
@interface HumanPuzzle : Puzzle {
	NSString* description;
}

/**
 Описание задачи
 */
@property(retain) NSString* description;

@property(readonly) int rightAnswer;

/**
 Создает новый случайный паззл
 
 @param difficulty сложность
 @param caller вызывающий объект
 */
+(id)puzzleWithDifficulty:(int)difficulty andCaller:(id<PuzzleObserver>)caller;

/**
 Возвращает правильный ответ на пазл
 */
-(int)rightAnswer;

/**
 Возвращает строку с заданием на пазл без ответа
 */
-(NSString*)taskString;

/**
 Возвращает строку с заданием на пазл и ответ
 */
-(NSString*)answerString;

@end

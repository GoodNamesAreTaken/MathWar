//
//  ExcersizePuzzleView.h
//  MathWars
//
//  Created by SwinX on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "PuzzleView.h"
#import "FFText.h"
#import "ExcersizePuzzle.h"

#define ANSWERS_AMOUNT 4

/**
 Общее представление для пазлов, для который необходимо сгенерировать 4 варианта ответов.
 
 Отображает задачу и варианты ответа
*/

@interface GenericPuzzleView : PuzzleView {
	NSArray* uniqueAnswers;
}

/**
 Создает представление по модели
 
 @param puzzle модель
 */
-(id)initWithPuzzle:(HumanPuzzle*)puzzle;

@end

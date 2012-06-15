//
//  PuzzleView.h
//  MathWars
//
//  Created by SwinX on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFSprite.h"
#import "FFText.h"
#import "FFTexture.h"
#import "FFEvent.h"
#import "Puzzle.h"
#import "SlidingView.h"
#import "HumanPuzzle.h"
#import "FFButton.h"

/**
 Обощенное представление паззла
 
 Отображает описание задания, оставшееся время, кнопки с вариантами ответов, правильный ответ по окончании
 */
@interface PuzzleView : SlidingView<PuzzleObserver> {
	FFText* description;
	FFText* task;
	FFText* time;
	FFSprite* back;
	FFSprite* clock;
	NSMutableArray* answersButtons;
	NSString* rightAnswer;
	FFEvent* finished;
    
    int rightAnswerIndex;
	
}
@property(readonly) CGPoint endPoint;
/**
 Кнопки с вариантами ответа
 */
@property(readonly) NSMutableArray* answersButtons;

/**
 Ширина
 */
@property(readonly) float width;

/**
 Высота
 */
@property(readonly) float height;

@property(readonly) FFEvent* finished;

@property(readonly) FFButton* rightAnswerButton;

/**
 Конструктор
 */
-(id)initWithPuzzle:(HumanPuzzle*)puzzle;

/**
 Показать правильный ответ
 */
-(void)showRightAnswer;

/**
 Установить новое значение счетчика времеи
 */
-(void)setRemainigTime:(float)newTime;

/**
 Установить описание задачи
 */
-(void)setDescription:(NSString *)newDescription;

-(void)showButtons;

@end

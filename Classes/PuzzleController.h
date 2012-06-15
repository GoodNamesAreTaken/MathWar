//
//  HumanPuzzleController.h
//  MathWars
//
//  Created by SwinX on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "HumanPuzzle.h"
#import "PuzzleView.h"
#import "FFController.h"
#import "FFTimer.h"
#import "PuzzleControllerState.h"
#import "FFSound.h"

/**
 Обощенный контроллер паззла
 
 Отвечает за отсчет времени, прием ответов от пользователя
 */
@interface PuzzleController : NSObject<FFController> {

	HumanPuzzle* model;
	PuzzleView* view;
	FFTimer* timer;
	FFSound* fallSound;
	int remainingTime;
	id<PuzzleControllerState> state;
	
	double puzzleTime;
	
	id<FFAction> slideAction;
	
}

/**
 Представление паззла
 */
@property(readonly) PuzzleView* view;


@property(readonly) Puzzle* model;

@property(retain) id<FFAction> slideAction;

/**
 Текущее остояние паззла
 
 Описывает поведение паззла во время появления на экране и удаления из игры
 */
@property(retain) id<PuzzleControllerState> state;

/**
 Создает паззл используя заданные модель и предствления
 
 @param puzzle модель
 @param puzzleView view
 */
-(id)initWithPuzzle:(Puzzle*)puzzle andView:(PuzzleView*)puzzleView;

/**
 Удаление контроллера из игры
 */
-(void)remove;

-(void)addActionsToButtons;

@end

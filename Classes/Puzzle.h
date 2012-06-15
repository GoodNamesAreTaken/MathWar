//
//  Puzzle.h
//  MathWars
//
//  Created by SwinX on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

@class Puzzle;

typedef enum _PuzzleState {
	PSUnanswered,
	PSSolved, 
	PSFailed
}PuzzleState;

enum difficulties {
	EASY_DIFFICULTY = 1,
	NORMAL_DIFFICULTY,
	HARD_DIFFICULTY
};

/**
 Наблюдатель паззла
 
 Принимает сообщение об удачном либо неудачном решениии паззла
 */
@protocol PuzzleObserver

/*
 Посылается в случае успешного решения паззла
 @param puzzle отправитель собщения
 */
-(void)puzzleWasSolved:(Puzzle*)puzzle;

/**
 Посылается в случае успешного решения паззла
 @param puzzle отправитель собщения
 */
-(void)puzzleWasFailed:(Puzzle*)puzzle;

@end

/**
 Абстрактный паззл
 
 Базовый класс для всех паззлов
 */
@interface Puzzle : NSObject {
	int difficulty;
	NSMutableArray* observers;
	PuzzleState state;
}

/**
 Сложность паззла
 */
@property(readonly) int difficulty;

/**
 Объект,вызвавший паззл
 */
@property(readonly) id<PuzzleObserver> firstObserver;

@property(readonly) BOOL solved;

@property(readonly) BOOL failed;

@property(readonly) BOOL answered;

/**
 Создает новый паззл
 @param delegate объект, вызвавший паззл
 @param puzzleDifficulty - сложность
 */
-(id)initWithDelegate:(id<PuzzleObserver>) delegate andDifficulty:(int)puzzleDifficulty;

/**
 Добавление нового наблюдателя к паззлу
 @param observer наблюдатель
 */
-(void)addObserver:(id<PuzzleObserver>)observer;

/**
 Завершает паззл неудачаей
 */
-(void)fail;

/**
 Удачное решение пазла
 */
-(void)success;

@end

//
//  HumanPlayer.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Player.h"

/**
 Делегат, принимающий от HumanPlayer сообщения о созданни паззлов
 */
@protocol PuzzleCreationDelegate

/**
 Посылается делагату при создании нового паззла
 @param puzzle созданный паззл
 */
-(void)puzzleCreated:(Puzzle*)puzzle;

@end


/**
 Игрок-человек
 
 Игрок, управляемый человеком. В ответ на большинстов действий ждет реакции от пользователя
 */
@interface HumanPlayer : Player {
	Unit* activeUnit;
	id<PuzzleCreationDelegate> puzzleCreationDelegate;

}

/**
 Делегат, который будет принимать сообщения о создании новых паззлов
 */
@property(assign) id<PuzzleCreationDelegate> puzzleCreationDelegate;

/**
 Текущий активный юнит
 */
@property(assign) Unit* activeUnit;

/**
 Метод, обеспечивающий возможность сдаться
 */
//-(void)lose;    //Мы не сдаемся! :Е

@end

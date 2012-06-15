//
//  PuzzleControllerState.h
//  MathWars
//
//  Created by Inf on 05.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//


@class PuzzleController;

/**
 Динамическое поведение контроллера паззлов
 
 Предназначен для измененения повдения контроллера пазлла в различных ситуациях
 */
@protocol PuzzleControllerState<NSObject>

/**
 Действия, выполняемые при поялении паззла
 @param controller контоллер паззла
 */
-(void) appear:(PuzzleController*)controller;

/**
 Действия, выполняемые при исчезновении паззла
 @param controller контоллер паззла
 */
-(void) disapear:(PuzzleController*)controller;

@optional
/**
 Досрочное удаление паззла по тачу.
 */
-(void)forceDisapear:(PuzzleController*)controller;

@end

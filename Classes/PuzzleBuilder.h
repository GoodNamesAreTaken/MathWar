//
//  PuzzleBuilder.h
//  MathWars
//
//  Created by Inf on 05.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "PuzzleController.h"
#import "Puzzle.h"

/**
 Построитель паззла
 
 Создает контроллер и представление паззла о его модели
 */
@interface PuzzleBuilder : NSObject {

}

/**
 Вовзращает экземпляр класса PuzzlePuilder
 */
+(id)sharedBuilder;

/**
 Создает представление и контроллер паззла
 
 @param puzzle модель паззла
 @retuns контроллер паззла
 */
-(PuzzleController*)buildViewControllerFromModel:(Puzzle*)puzzle;

@end

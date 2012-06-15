//
//  StandalonePuzzleControllerState.h
//  MathWars
//
//  Created by Inf on 05.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "PuzzleControllerState.h"
#import "FFTimer.h"

/**
 Состояение конроллера, описывающего поведение самостоятельного паззла
 
 Затеняет экран при появлении и снимает затенение через 3 секунды после исчезновения
 */
@interface StandalonePuzzleControllerState : NSObject<PuzzleControllerState> {
	PuzzleController* targetController;
	FFTimer* timer;
}

/**
 Возвращает экземпляр объекта
 */
+(id)state;

@end

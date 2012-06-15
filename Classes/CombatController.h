//
//  CombatController.h
//  MathWars
//
//  Created by SwinX on 03.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFController.h"
#import "CombatView.h"
#import "Combat.h"
#import "PuzzleController.h"
#import "FFTimer.h"
#import "HumanPlayer.h"
#import "CombatUnitSound.h"

/**
 Контроллер боя
 
 Отвечает за создание и завершение боя, создание паззлов во вемя боя
 */
@interface CombatController : NSObject<FFController, PuzzleCreationDelegate> {

	CombatView* view;
	Combat* model;
	
	CombatUnitSound* soundView;
	FFSound* attackerSound;
	FFSound* protectorSound;
}

+(id)controllerWithView:(CombatView*)combatView andModel:(Combat*)combatModel;

/**
 Создает контроллер используя заданные модель и представление
 
 @param combatView представление
 @param combatModel модель
 */
-(id)initWithView:(CombatView*)combatView andModel:(Combat*)combatModel;

/**
 Выход из боя
 */
-(void)exitCombat;

@end

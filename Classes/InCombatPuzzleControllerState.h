//
//  InCombatPuzzleControllerState.h
//  MathWars
//
//  Created by Inf on 05.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "PuzzleControllerState.h"

/**
 Состояние контроллера, описывающее поведение паззла как составной части боя
 
 Мгновенно отображает паззл после создания и мгновеено убирает его после решения
 */
@interface InCombatPuzzleControllerState : NSObject<PuzzleControllerState> {

}

+(id)state;
@end

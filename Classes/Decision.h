//
//  Descision.h
//  MathWars
//
//  Created by SwinX on 01.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "AIPlayer.h"

@class AIPlayer;

@interface Decision : NSObject {

	AIPlayer* decisive;
	
}

@property(assign) AIPlayer* decisive;


/**
 Конструктор
 @param player Ссылка на AI, который принимает решения
 */
-(id)initWithPlayer:(AIPlayer*) player;

/**
 Выполнить решение, принятое AI. Должен быть переопределен потомками
 */
-(void)performDecision;

@end

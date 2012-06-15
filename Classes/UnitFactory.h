//
//  UnitFactory.h
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "Player.h"
#import "Unit.h"

/**
 Фабрика юнитов.
 
 Класс-синглтон для производства новых юнитов
 */
@interface UnitFactory : NSObject {
	Unit* prototypes[MWTotalUnitsCount];

}

/**
 Возвращает экзепляр класса UnitFactory
 */
+(UnitFactory*)sharedFactory;

/**
 Создает новый юнит заданного типа с заданным владельцем
 @param type тип юнита
 @param owner владелец юнита
 */
-(Unit*)createUnitOfType:(uint8_t)type withOwner:(Player*) owner;

@end

//
//  MapObject.h
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Unit.h"
#import "Combat.h"
/**
 Объект карты
 
 Базовый класс для всех объектов карты
 */
@interface MapObject : NSObject<CombatObserver> {
	uint8_t objectId;
	
	NSMutableArray* neighbours;
	Unit* guardian;
	float x;
	float y;
}


@property(readonly) BOOL isNeutral;

/**
 ID объекта. Используется при передаче по сети
 */
@property uint8_t objectId;

/**
 Список соседних объектов
 */
@property(retain) NSMutableArray* neighbours;

/**
 Стражник объектов
 */
@property(retain) Unit* guardian;

/**
 Положение на карте. X
 */
@property float x;

/**
 Положение на карте. Y
 */
@property float y;

/**
 Вызываеться при входе юнита в этот объект 
 
 Базовая реализация выполняет следующие действия:
 1) Если объект свободен, то юнит становится стражником
 2) Если объект занят юнитом противника, начать бой. Победивший юнит становится новым стражником
 Метод может быть переопределен потомками
 */
-(void)onUnitEnter:(Unit*)unit;

-(void)unitEnteredEmptyCell:(Unit*)unit;
-(BOOL)belongsTo:(Player*)player;
-(void)cleanAllRoads;



@end

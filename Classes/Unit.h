//
//  Unit.h
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

//#import "Player.h"
@class Player;
@class Unit;
#define MAXIMUM_UPGRADES 2

typedef enum _UnitType {
	MWUnitTank = 0,
	MWUnitGunner,
	MWUnitCannoneer,
	MWUnitTitan,
	MWUnitAnnihilator,
	
	MWUnitBaseProtector,
	MWTotalUnitsCount
}MWUnitType;
@class MapObject;

/**
 Объект-наблюдатель для юнита
 */
@protocol UnitObserver<NSObject>

/**
 Юнит переместился в дрегую локацию
 @param target новая локация
 */

-(void)unit:(Unit*)_unit startedMovingTo:(MapObject*)location withFinishAction:(SEL)action;
@optional
-(void)unit:(Unit*)_unit finishedMovingTo:(MapObject*)location;
-(void)unitWasSelected:(Unit*)_unit;
-(void)unitSelectionWasRemoved:(Unit*)_unit;
-(void)unitUpgraded:(Unit*)_unit;

-(void)unit:(Unit*)unit hasBecomeGuardianOf:(MapObject*)unit;

/**
 Юнит умер :( Это печально :(
 */
-(void)unitDied;

@end


/**
 Юнит.
 
 Боевая единица игроков. Создается на базах, обязательно принадлежит какому-либо игроку.
 */
@interface Unit : NSObject {
	uint8_t type;
	Player* owner;
	int8_t health;
	uint8_t attack;
	int8_t maxHealth;
	uint8_t upgrades;
	BOOL isDead;
	MapObject* location;
	MapObject* previousLocation;
	
	uint16_t unitID;
	
	NSMutableArray* observers;
}

/**
 Тип юнита
 */
@property(readonly) uint8_t type;

/**
 Максимальный запас здоровья юнита
 */
@property int8_t maxHealth;

/**
 Текущий уровень здоровья. Если он <=0, то юнит мертв
 */
@property int8_t health;

/**
 Текущий уровень атаки. Если он <=0, то юнит мертв
 */
@property uint8_t attack;

/**
 Количество апгрейдов, сделанных для данного юнита
 */
@property uint8_t upgrades;

/**
 Владалец юнита
 */
@property(assign) Player* owner;

/**
 Локация, на которой расположен юнит
 */
@property(readonly, assign) MapObject* location;

/**
 Локация, на которой юнит размещался ранее
 */
@property(assign) MapObject* previousLocation;

/**
 Возможно ли апгрейдить юнита
 */
@property(readonly) BOOL canBeUpgraded;

/**
 Идентификатор юнита
 */
@property uint16_t unitID;

/**
 Мертв юнит или нет
 */
@property BOOL isDead;

/**
 Создает новый юнит заданного типа
 */
-(id)initWithType:(uint8_t)unitType;

/**
 Копирует юнит и назначает ему нового владельца
 */
-(Unit*)copyWithNewOwner:(Player*)copyOwner;

/**
 Перемещает юнит в новою локацию
 */
-(void)tryToMoveTo:(MapObject*)newLocation;

/**
 Принудительно заставляет юнит начать двигаться в новую локацию, не проверяя, остались ли у игрока очки хода
 */
-(void)moveTo:(MapObject*)newLocation;

/**
 Убивает юнит
 */
-(void)die;

/**
 Вызывается, когда юнит становится активным
 */
-(void)select;

/**
 Вызывается, когда юнит перестает быть активным 
 */
-(void)cancelSelection;

/**
 Событие, вызываемое при улучшении юнита
 */
-(void)unitUpgraded;

/**
 Добавлет наблюдателя
 @param observer;
 */
-(void)addObserver:(id<UnitObserver>) observer;

/**
 Убирает наблюдателя
 @param observer наблюдатель, которого необходимо убрать
 */
-(void)removeObserver:(id<UnitObserver>) observer;

-(void)becomeGuardianOf:(MapObject*)object;

@end

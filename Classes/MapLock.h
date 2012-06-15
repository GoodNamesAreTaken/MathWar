//
//  MapLock.h
//  MathWars
//
//  Created by Inf on 03.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//


/**
 Блокорвщик карты
 
 Предназначен для блокировки карты в различных ситуациях (например, во время хода противника или во время паззла)
 */
@interface MapLock : NSObject {
	BOOL isPlayerTurn;
	BOOL hasMovingUnit;
	BOOL dialogAtScreen;
	BOOL hasActivePuzzle;
	BOOL hasActiveCombat;
}

-(void)setDefault;

/**
 Флаг устанавливается в TRUE, если сейчас ход игрока
 */
@property BOOL isPlayerTurn;

/**
 Флаг устанавливается в TRUE если в данный момент решаеться паззл.
 */
@property BOOL hasActivePuzzle;

/**
 Флаг устанавливается в TRUE если в данный момент происходит бой.
 */
@property BOOL hasActiveCombat;

/**
 Флаг устанавливается в YES если есть юниты незавршившие движение
 */
@property BOOL hasMovingUnit;

/**
 Флаг устанавливается в YES, если на экране есть какой-либо диалог
 */
@property BOOL dialogAtScreen;

/**
 TRUE, если карта заблокирована
 */
@property(readonly) BOOL isMapLocked;

@end

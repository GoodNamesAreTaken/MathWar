//
//  Factory.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Building.h"
#import "Puzzle.h"
#import "PlayerObserver.h"

#import "BuildingFactoryTask.h"
#import "UpdgradingFactoryTask.h"

@class Factory;
@protocol FactoryObserver

-(void)factory:(Factory*)factory startedBuldingUnit:(uint8_t)unitType;
-(void)factoryStartedUpgrade:(Factory*)factory;
@optional
-(void)factory:(Factory*)factory upgradedUnit:(Unit*)unit;



@end


/**
 Делегат базы
 
 Принимает различные сообщение от базы
 */
@protocol FactoryDelegate<BuildingDelegate>

/**
 Посылается успешном при строительстве нового юнита
 @param unit только что построенный юнит
 */
-(void)buildedUnit:(Unit*)unit;

/**
 Посылается после апгрейда юнита
 */
-(void)upgradeStarted;

@end


/**
 Фабрика
 
 Добавляет к постройке возможность строить юнит и апгрейдить его
 */
@interface Factory : Building<PuzzleObserver, PlayerObserver> {
	id<FactoryState> task;
	
	BOOL buildedUnitThisTurn;
	NSMutableArray* observers;
}

/**
 Отдает приказ построить новый юнит заданного типа. Создается паазл и если игрок решает его, то стражником базы становится новый юнит
 @param type тип юнита
 */

@property BOOL buildedUnitThisTurn;

-(void)buildUnitOfType:(uint8_t)type;
-(void)upgradeGuardian;

-(void)addObserver:(id<FactoryObserver>) observer;
-(void)removeObserver:(id<FactoryObserver>) observer;

@end

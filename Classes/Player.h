//
//  HumanPlayer.h
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Combat.h"
#import "PlayerObserver.h"
#import "UnitRestrictions.h"

@class Unit;
@class Factory;

/**
 Базовый объект для всех игроков
 
 Выполняет общие для всех видов игроков действия. Различные типы игроков(AI, Human, Network, Online) должны наследоватся от этого класса
 */
@interface Player : NSObject {
	int moveCount;
	
	int currentID;
	
	NSMutableArray* observers;
	NSMutableArray* units;
	int factoriesAmount;
	
	id<UnitRestrictions> restrictions;
}

@property(nonatomic, retain) id<UnitRestrictions> restrictions;
/**
 Количество возможных перемещений на данный ход
 */
@property int moveCount;

/**
 Юниты игрока
 */
@property(readonly) NSMutableArray* units;

/**
 Количество ходов, сделанных игроком
 */
//@property(readonly) uint16_t turnsPassed;

-(Unit*)getUnitByID:(uint16_t)unitID;

/**
 Уведомить игрока о начале боя
 @param combat начавшийся бой
 */
-(void)startCombat:(Combat*)combat;

/**
 Уведомить игорока о завершении боя
 
 @param завкончившийся бой
 */
-(void)finishCombat:(Combat*)combat;

/**
 Уведомить игрока о завершении раунда боя
 */
-(void)finishCombatRound:(Combat*)combat;

-(void)readyToNextRoundOfCombat:(Combat*)combat;

/**
 Создает паззл для игрока
 @param difficulty сложность
 @param delegate делегат, принимающий сообщения о завершении боя
 */
-(Puzzle*)createPuzzleOfDifficulty:(uint32_t)difficulty withDelegate:(id<PuzzleObserver>) delegate;

/**
 Начать ход
 */
-(void)startTurn;

/**
 Завершить ход
 */
-(void)endTurn;

/**
 Связать базу с игроком
 @param factory фабрика
 */
-(void)assignFactory:(Factory*)factory;

/**
 Забрать базу у игрока
 @param factory фабрика
 */
-(void)unassignFactory:(Factory*)factory;

/**
 Связать юнит с игроком
 @param unit юнит
 */
-(void)assignUnit:(Unit*)unit;

/**
 Забрать юнит у игрока
 @param unit юнит
 */
-(void)unassignUnit:(Unit*)unit;

/**
 Добавить к юниту объект-наблюдатель. Увеличивает счетчик ссылок наблюдателя
 @param observer наблюдатель
 */
-(void)addObserver:(id<PlayerObserver>)observer;

/**
 Удалить наблюдатель
 @param observer удаляемый наблюдатель. Уменьшает счетчик ссылок наблюдателя
 */
-(void)removeObserver:(id<PlayerObserver>)observer;

-(void)surrender;

-(void)lose;

-(void)combatExited;

-(void)showNotification:(NSString*)text;

@end

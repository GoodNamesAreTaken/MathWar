//
//  Combat.h
//  MathWars
//
//  Created by Inf on 25.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "Puzzle.h"

@class Combat;
@class Unit;
@class Player;

/**
 Пртокол наблюдателя за боем
 
 Принимает сообщения о ходе боя
 */
@protocol CombatObserver<NSObject>

@optional
/**
 Послыается после выхода пользователем из боя
 */
-(void)userExitedCombat:(Combat*)combat withWinner:(Unit*)winner;

/**
 Послылается при атаке одного из юнитов
 @param unit атакующий юнит
 @deprecated
 */
-(void)unitAttacked:(Unit*)unit;

-(void)attacker:(Unit*)_attacker strikedProtector:(Unit*)_protector;
-(void)protector:(Unit*)_protector strikedAttacker:(Unit*)_attacker;
-(void)draw;
-(void)attackerDeath;
-(void)protectorsBeatenBy:(Unit*)attacker;
/**
 посылается, когда битва закончиась и пользователь вышел из нее с помощью кнопки
 */
-(void)combatExited;

/**
 Посылается при смене защитника
 */
-(void)protectorChangedFrom:(Unit*)oldProtector to:(Unit*)newProtector;

@end

/**
 Бой между двумя юнитами
 
 Отвечает за сражение между двумя юнитами. 
 Создает паззлы для каждого из игроков, принимает результаты. Игрок, первым решившим задачу наносит повреждения. Если жизнь какого-либо из юнитов стало равно 0 то бой завершается
 О ходе боя сообщается всем заинтересованным наблюдателям
 */
@interface Combat : NSObject<PuzzleObserver> {
	Unit* attacker;
	
	NSArray* protectors; 
	uint32_t currentProtector;
	
	Puzzle* attackerPuzzle;
	Puzzle* protectorPuzzle;
	
	uint32_t puzzleDifficulty;
	
	NSMutableArray* observers;
	
	BOOL attackerReady;
	BOOL protectorReady;
}

@property(readonly) BOOL isFinished;
/**
 Первый участник боя
 */
@property(readonly) Unit* attacker;

/**
 Второй участник боя
 */
@property(readonly) Unit* protector;

/**
 Наблюдатель, который вызвал бой
 */
@property(readonly) id<CombatObserver> delegate;

/**
 Создает новый бой между одним атакующим юнитом и несколькими защищаюсимися
 
 @param first атакующий юнит
 @param second защищающийся юнит
 @param delegate спорный объект
 */
+(id)startCombatBetweenAttacker:(Unit*)attackerUnit andProtectors: (NSArray*)protectors andDelegate:(id<CombatObserver>)delegate;

/**
 Создает новый бой между заданными юнитами
 
 @param first атакующий юнит
 @param second защищающийся юнит
 @param delegate спорный объект
 */
+(id)startCombatBetweenAttacker:(Unit*)attackerUnit andProtector: (Unit*)protectorUnit andDelegate:(id<CombatObserver>)delegate;

/**
 Инициализация боя заданными юнитами и делегатом
 */
-(id)initWithAttacker:(Unit*)attackerUnit andProtectors: (NSArray*)protectorsList andDelegate:(id<CombatObserver>)combatDelegate;

/**
 Начинает новый раунд боя
 */
-(void)startRound;

/**
 Добавляет нового наблюдателя боя
 */
-(void)addObserver:(id<CombatObserver>)observer;


/**
 Необходимо вызвать этот метод извне, чтобы сообщить наблюдателям о том, что игроки вышли из боя
 */
-(void)combatExited;

-(void)playerReady:(Player*)player;

@end

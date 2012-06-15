//
//  TestCombat.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "TestCombat.h"
#import "PlayerProtocol.h"
#import "Unit.h"

#define typeof __typeof__

@implementation TestCombat

-(void)setUp {
	mockPlayer = [OCMockObject mockForProtocol:@protocol(PlayerProtocol)];
	
	
	mockEnemy = [OCMockObject mockForProtocol:@protocol(PlayerProtocol)];
	
	mockPlayerUnit = [OCMockObject mockForClass:[Unit class]];
	
	[[[mockPlayerUnit stub] andReturn:mockPlayer] owner];
	
	mockEnemyUnit = [OCMockObject mockForClass:[Unit class]];
	
	[[[mockEnemyUnit stub] andReturn:mockEnemy] owner];
	
	
	mockPlayerPuzzle = [OCMockObject mockForClass:[Puzzle class]];
	mockEnemyPuzzle = [OCMockObject mockForClass:[Puzzle class]];
	
	mockDelegate = [OCMockObject mockForProtocol:@protocol(CombatObserver)];
	
	combat = [[Combat alloc] initWithAttacker:mockPlayerUnit andProtector:mockEnemyUnit andDelegate:mockDelegate];
}

-(void)tearDown {
	[combat release];
}

-(void)testRoundStart {
	[[[mockPlayer expect] andReturn:mockPlayerPuzzle] createPuzzleOfDifficulty:1 withDelegate:combat];
	[[[mockEnemy expect] andReturn:mockEnemyPuzzle] copyPuzzle:mockPlayerPuzzle];
	
	[combat startRound];
	
	[mockPlayer verify];
}

-(void)testRoundWithPlayerLose {
	int8_t health = 2;
	uint8_t attack = 1;
	
	[[[mockPlayer stub] andReturn:mockPlayerPuzzle] createPuzzleOfDifficulty:1 withDelegate:combat];
	[[[mockEnemy stub] andReturn:mockEnemyPuzzle] copyPuzzle:mockPlayerPuzzle];
	
	[[[mockPlayerUnit stub] andReturnValue:OCMOCK_VALUE(health)] health];
	[[[mockEnemyUnit stub] andReturnValue:OCMOCK_VALUE(attack)] attack];
	[[[mockEnemyUnit stub] andReturnValue:OCMOCK_VALUE(health)] health];
	
	[[mockPlayerUnit expect] setHealth:1];
	
	[[mockPlayerPuzzle expect] fail];
	[[mockDelegate expect] unitAttacked:mockEnemyUnit];
	
	[combat startRound];
	[combat puzzleWasSolved:mockEnemyPuzzle];
	
	[mockPlayerPuzzle verify];
	[mockPlayerUnit verify];
	[mockDelegate verify];
	
}

-(void)testRoundWithPlayerWin {
	int8_t health = 2;
	uint8_t attack = 1;
	
	[[[mockPlayer stub] andReturn:mockPlayerPuzzle] createPuzzleOfDifficulty:1 withDelegate:combat];
	[[[mockEnemy stub] andReturn:mockEnemyPuzzle] copyPuzzle:mockPlayerPuzzle];
	[[[mockPlayerUnit stub] andReturnValue:OCMOCK_VALUE(health)] health];
	
	[[[mockEnemyUnit stub] andReturnValue:OCMOCK_VALUE(health)] health];
	[[[mockPlayerUnit stub] andReturnValue:OCMOCK_VALUE(attack)] attack];
	
	[[mockEnemyUnit expect] setHealth:1];
	[[mockEnemyPuzzle expect] fail];
	[[mockDelegate expect] unitAttacked:mockPlayerUnit];
	
	[combat startRound];
	[combat puzzleWasSolved:mockPlayerPuzzle];
	
	[mockEnemyPuzzle verify];
	[mockEnemyUnit verify];
	[mockDelegate verify];
}

-(void)testRoundWithTwoErrors {
	id mockCombat = [OCMockObject partialMockForObject:combat];
	
	[[[mockPlayer stub] andReturn:mockPlayerPuzzle] createPuzzleOfDifficulty:1 withDelegate:combat];
	[[[mockEnemy stub] andReturn:mockEnemyPuzzle] copyPuzzle:mockPlayerPuzzle];
	
	[mockCombat startRound];
	
	[mockCombat puzzleWasFailed:mockPlayerPuzzle];
	[[mockCombat expect] startRound];
	[mockCombat puzzleWasFailed:mockEnemyPuzzle];
	
	[mockCombat verify];
}

-(void)setNullPlayerHealth {
	uint8_t health = 0;
	[[[mockPlayerUnit stub] andReturnValue:OCMOCK_VALUE(health)] health];
}

-(void)testRoundWithPlayerDeath {
	//Написать позже
}

-(void)testRoundWithEnemyDeath {
	//Написать позже
}


@end

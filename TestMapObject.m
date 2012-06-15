//
//  TestMapObject.m
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import <OCMock/OCMock.h>
#import "PlayerProtocol.h"
#import "MapObject.h"
#import "TestMapObject.h"


@implementation TestMapObject

-(void)createMapObject {
	mapObject = [[MapObject alloc] init];
}

-(void)setUp {
	mockPlayer = [OCMockObject mockForProtocol:@protocol(PlayerProtocol)];
	mockEnemy = [OCMockObject mockForProtocol:@protocol(PlayerProtocol)];
	mockPlayerUnit = [OCMockObject mockForClass:[Unit class]];
	mockEnemyUnit = [OCMockObject mockForClass:[Unit class]];
	mockCombat = [OCMockObject mockForClass:[Combat class]];
	
	[[[mockCombat stub] andReturn:mockPlayerUnit] attacker];
	[[[mockCombat stub] andReturn:mockEnemyUnit] protector];
	
	[[[mockPlayerUnit stub] andReturn:mockPlayer] owner];
	[[[mockEnemyUnit stub] andReturn:mockEnemy] owner];
	
	[[mockPlayer stub] createPuzzleOfDifficulty:1 withDelegate:[OCMArg any]];
	[[mockPlayer stub] copyPuzzle:[OCMArg any]];
	[[mockEnemy stub] createPuzzleOfDifficulty:1 withDelegate:[OCMArg any]];
	[[mockEnemy stub] copyPuzzle:[OCMArg any]];
	
	[self createMapObject];
	
}

-(void)tearDown {
	[mapObject release];
}

-(void)testEmptyObject {
	STAssertNotNil(mapObject.neighbours, @"Соседи должны быть заданы");
	STAssertNil(mapObject.guardian, @"В новом объекте не должно быть стражника");
	
	[mapObject onUnitEnter:mockPlayerUnit];
	
	STAssertEquals(mapObject.guardian, mockPlayerUnit, @"Стражник должен сменится");
}

-(void)testGuardedObject {
	mapObject.guardian = mockPlayerUnit;
	
	[[mockPlayer expect] startCombat:([OCMArg any])];
	[[mockEnemy expect] startCombat:([OCMArg any])];
	
	[mapObject onUnitEnter:mockEnemyUnit];
	
	[mockPlayer verify];
	[mockEnemy verify];
}

-(void)testCombatLose {
	
	
	mapObject.guardian = mockPlayerUnit;
	[[mockPlayer stub] startCombat:(Combat*)[OCMArg any]];
	[[mockEnemy stub] startCombat:(Combat*)[OCMArg any]];
	
	[mapObject onUnitEnter:mockEnemyUnit];
	[mapObject combat:nil finishedWithWinner:mockEnemyUnit];

	STAssertEquals(mapObject.guardian, mockEnemyUnit, @"В случае проигрыша атакующий должен стать стражником");
}

-(void)testCombatWin {
	mapObject.guardian = mockPlayerUnit;
	[[mockPlayer stub] startCombat:(Combat*)[OCMArg any]];
	[[mockEnemy stub] startCombat:(Combat*)[OCMArg any]];
	
	
	[mapObject onUnitEnter:mockEnemyUnit];
	[mapObject combat:nil finishedWithWinner:mockPlayerUnit];
	STAssertEquals(mapObject.guardian, mockPlayerUnit, @"В случае выигрыша стражник не должен меняться");
}

@end

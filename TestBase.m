//
//  TestBase.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "Puzzle.h"
#import "Factory.h"
#import "TestBase.h"

#define typeof __typeof__

@implementation TestBase

-(void)setUp {
	[super setUp];
	mockPuzzle = [OCMockObject mockForClass:[Puzzle class]];
	((Factory*)mapObject).owner = mockPlayer;
}

-(void)createMapObject {
	mapObject = [[Factory alloc] init];
}

-(void)testOwnerChange {
	id mockDelegate = [OCMockObject mockForProtocol:@protocol(BaseDelegate)];
	
	((Factory*)mapObject).delegate = mockDelegate;
	[[mockDelegate expect] ownerChangedTo:mockEnemy];
	
	[[mockPlayer expect] unassignFactory:(Factory*)mapObject];
	[[mockEnemy expect] assignFactory:(Factory*)mapObject];
	
	[((Factory*)mapObject) onOwnerChange:mockEnemy];
	
	[mockPlayer verify];
	[mockEnemy verify];
	[mockDelegate verify];
}

-(void)testBuildUnit {
	int buildCount=1;
	
	[[[mockPlayer stub] andReturnValue:OCMOCK_VALUE(buildCount)] buildCount];
	
	//[[mockPlayer expect] createPuzzleOfDifficulty:1 withDelegate:[OCMArg any]];
	[[mockPlayer expect] setBuildCount:0];
	
	[((Factory*)mapObject) buildUnitOfType:(uint8_t)MWUnitTank];
	
	[mockPlayer verify];
	
}

-(void)testSuccesfulBuild {
	int buildCount=1;
	id mockDelegate = [OCMockObject mockForProtocol:@protocol(BaseDelegate)];
	
	[[mockDelegate expect] buildedUnit:[OCMArg any]];
	
	[[[mockPlayer stub] andReturn:mockPuzzle] createPuzzleOfDifficulty:1 withDelegate:(Factory*)mapObject];
	[[[mockPlayer stub] andReturnValue:OCMOCK_VALUE(buildCount)] buildCount];
	
	[[mockPlayer expect] assignUnit:(Unit*)[OCMArg any]];
	 
	[[mockPlayer stub] setBuildCount:0];
	
	((Factory*)mapObject).delegate = mockDelegate;
	
	[(Factory*)mapObject buildUnitOfType:MWUnitTank];
	
	[(Factory*)mapObject puzzleWasSolved:mockPuzzle];
	
	STAssertNotNil(mapObject.guardian, @"Должен появится стражник");
	STAssertEquals(mapObject.guardian.type, (uint8_t)MWUnitTank, @"Стражник должен быть танком");

	[mockDelegate verify];
}

-(void)testCombatLose {
	[[mockPlayer stub] unassignFactory:(Factory*)mapObject];
	[[mockEnemy stub] assignFactory:(Factory*)mapObject];
	
	[super testCombatLose];
}

-(void)testUnsuccessfulBuild {
	int buildCount=1;
	[[[mockPlayer stub] andReturn:mockPuzzle] createPuzzleOfDifficulty:1 withDelegate:(Factory*)mapObject];
	[[[mockPlayer stub] andReturnValue:OCMOCK_VALUE(buildCount)] buildCount];
	[[mockPlayer stub] setBuildCount:0];
	
	[(Factory*)mapObject buildUnitOfType:MWUnitTank];
	
	[(Factory*)mapObject puzzleWasFailed:mockPuzzle];
	
	STAssertNil(mapObject.guardian, @"Стражник не должен появиться");
}

@end

//
//  TestUnits.m
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import <OCMock/OCMock.h>
#import "MapObject.h"
#import "UnitFactory.h"
#import "TestUnits.h"

#define typeof __typeof__

@implementation TestUnits
                         

-(void)testTankFactory {
	Unit* unit;
	id mockPlayer = [OCMockObject mockForProtocol:@protocol(PlayerProtocol)];
	
	[[mockPlayer expect] assignUnit:(Unit*)[OCMArg any]];
	
	UnitFactory* factory = [[UnitFactory alloc] init];
	
	unit = [factory createUnitOfType:MWUnitTank	withOwner:mockPlayer];
	
	STAssertEquals(unit.type, (uint8_t)MWUnitTank, @"Нужен танк");
	STAssertEquals(unit.maxHealth, (int8_t)1, @"Жизнь танка должна быть очень низкой");
	STAssertEquals(unit.attack, (uint8_t)2, @"Атака танка должна быть низкой");
	STAssertEquals(unit.health, unit.maxHealth, @"Здоровье должно быть максимальным");
	STAssertEquals(unit.owner, mockPlayer, @"Владелец задан неверно");
	STAssertNil(unit.location, @"Начальная локация должна быть пустой");
	
}


-(void)testMove {
	int moveCount=1;
	Unit* unit = [[Unit alloc] initWithType:MWUnitTank];
	
	id mockOldLocation = [OCMockObject mockForClass:[MapObject class]];
	unit.location = mockOldLocation;
	
	
	id mockLocation = [OCMockObject mockForClass:[MapObject class]];
	id mockPlayer = [OCMockObject mockForProtocol:@protocol(PlayerProtocol)];
	
	id mockObserver = [OCMockObject mockForProtocol:@protocol(UnitObserver)];
	
	[[[mockPlayer stub] andReturnValue:OCMOCK_VALUE(moveCount)] moveCount];
	[[mockPlayer stub] assignUnit:unit];
	
	[[mockOldLocation expect] setGuardian:nil];
	[[mockObserver expect] unit:unit MovedTo:mockLocation];
	[[mockPlayer expect] setMoveCount:0];
	[[mockLocation expect] onUnitEnter:unit];
	
	
	[unit addObserver:mockObserver];
	unit.owner = mockPlayer;
	
	
	[unit tryToMoveTo:mockLocation];
	
	STAssertEquals(unit.location, mockLocation, @"Локация должна измениться");
	
	[mockLocation verify];
	[mockPlayer verify];
	[mockOldLocation verify];
	[mockObserver verify];
	
}




@end


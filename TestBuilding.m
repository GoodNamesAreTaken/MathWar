//
//  TestBuilding.m
//  MathWars
//
//  Created by Inf on 25.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Building.h"
#import "TestBuilding.h"


@implementation TestBuilding

-(void)createMapObject {
	mapObject = [[Building alloc] init];
}

-(void)testEmptyObject {
	[super testEmptyObject];
	STAssertEquals(((Building*)mapObject).owner, mockPlayer, @"Строение должно сменить владельца");
}

-(void)testCombatWin {
	[super testCombatWin];
	STAssertEquals(((Building*)mapObject).owner, mockPlayer, @"Строение не должно менять владельца в случае победы");
}

-(void)testCombatLose {
	[super testCombatLose];
	STAssertEquals(((Building*)mapObject).owner, mockEnemy, @"Строение должно cменить владельца в случае победы");
}

-(void)testNilGuardian {
	
	mapObject.guardian = mockPlayerUnit;
	
	STAssertEquals(((Building*)mapObject).owner, mockPlayer, @"При смене стража владелец должен смениться на владельца стража");
	mapObject.guardian = nil;
	
	STAssertEquals(((Building*)mapObject).owner, mockPlayer, @"При уходе стража владелец должен остаться прежним");
}

@end

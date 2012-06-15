//
//  TestHumanPlayer.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Player.h"

@interface TestPlayer : SenTestCase {
	Player* player;
	id mockDelegate;
}

-(void)testTurnStart;
-(void)testTurnEnd;
-(void)testAbstractMethods;

@end

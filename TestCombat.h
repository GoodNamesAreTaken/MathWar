//
//  TestCombat.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Combat.h"


@interface TestCombat : SenTestCase {
	id mockPlayerUnit;
	id mockEnemyUnit;
	
	id mockPlayer;
	id mockEnemy;
	
	id mockPlayerPuzzle;
	id mockEnemyPuzzle;
	
	id mockDelegate;
	
	Combat* combat;
}

-(void)testRoundStart;
-(void)testRoundWithPlayerLose;
-(void)testRoundWithPlayerWin;

-(void)testRoundWithTwoErrors;

-(void)testRoundWithPlayerDeath;
-(void)testRoundWithEnemyDeath;

@end

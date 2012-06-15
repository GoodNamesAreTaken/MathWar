//
//  TestHumanPlayer.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "Unit.h"
#import "TestPlayer.h"
#import "Combat.h"


@implementation TestPlayer

-(void)setUp {
	//mockEnemy = [OCMockObject mockForProtocol:@protocol(PlayerProtocol)];
	mockDelegate = [OCMockObject mockForProtocol:@protocol(PlayerDelegate)];
	player = [[Player alloc] init];
	player.delegate = mockDelegate;
}

-(void)tearDown {

	[player release];
}

-(void)testTurnStart {
	[[mockDelegate expect] playerStartedTurn:player];
	[player startTurn];
	
	STAssertEquals(player.moveCount, 1, @"В начале раунда должен быть доступен 1 ход");
	STAssertEquals(player.buildCount, 1, @"В начале раунда должна быть доступна одна постройка");
	//STAssertTrue(player.active, @"В начале раунда флаг активности должен быть установлен");
	
	[mockDelegate verify];
}

-(void)testTurnEnd {
	[[mockDelegate expect] playerFinishedTurn:player];
	[player endTurn];
	
	//STAssertFalse(player.active, @"В конце раунда флаг активности должен быть сброшен");
	
	[mockDelegate verify];
}

-(void)testAbstractMethods {
	STAssertThrows([player createPuzzleOfDifficulty:1 withDelegate:nil], @"Player не должен реализовывать создание пазлов");
	STAssertThrows([player copyPuzzle:nil], @"Player не должен реализовывать копирование пазлов");
}

@end

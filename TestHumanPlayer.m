//
//  TestHumanPlayer.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "Puzzle.h"å
#import "HumanPuzzle.h"
#import "TestHumanPlayer.h"


@implementation TestHumanPlayer

-(void)setUp {
	player = [[HumanPlayer alloc] init];
}

-(void)testPuzzleCreation {
	/*id mockDelegate = [OCMockObject mockForProtocol:@protocol(PuzzleDelegate)];
	id mockPlayerDelegate = [OCMockObject mockForProtocol:@protocol(HumanPlayerDelegate)];
	player.delegate = mockPlayerDelegate;
	
	Puzzle* delegatePuzzle;
//	[[mockPlayerDelegate expect] puzzleCreated:[OCMArg setTo:delegatePuzzle]];
	Puzzle* puzzle = [player createPuzzleOfDifficulty:1 withDelegate:mockDelegate];
	
	STAssertTrue([puzzle isKindOfClass:[HumanPuzzle class]], @"HumanPlayer должен создавать HumanPuzzle");
	STAssertEquals(puzzle.delegate, mockDelegate, @"Делегат задан неверно");
	
	[mockPlayerDelegate verify];
	
	STAssertEquals(delegatePuzzle, puzzle, @"Делегат толжен получить тот же паззл что и вызывающий");*/
}

@end

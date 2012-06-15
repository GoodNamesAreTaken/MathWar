//
//  TestHumanPlayer.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "HumanPlayer.h"


@interface TestHumanPlayer : SenTestCase {
	HumanPlayer* player;
}

-(void)testPuzzleCreation;

@end

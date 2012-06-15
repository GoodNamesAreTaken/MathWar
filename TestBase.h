//
//  TestBase.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "TestBuilding.h"


@interface TestBase : TestBuilding {
	id mockPuzzle;

}

-(void)testBuildUnit;

-(void)testSuccesfulBuild;

-(void)testUnsuccessfulBuild;

-(void)testOwnerChange;

@end

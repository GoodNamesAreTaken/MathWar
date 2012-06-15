//
//  BuildingFactoryTask.m
//  MathWars
//
//  Created by Inf on 30.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "Factory.h"
#import "BuildingFactoryTask.h"
#import "UnitHelper.h"

@implementation BuildingFactoryTask
@synthesize guardianType, factory;

-(void)doTask {
	Unit* newUnit = [[UnitHelper sharedHelper] getUnit:guardianType withOwner:factory.owner];
	[newUnit becomeGuardianOf:self.factory];
	newUnit.previousLocation = self.factory;
	
	
	if ([self.factory.delegate respondsToSelector:@selector(buildedUnit:)]) {
		[self.factory.delegate buildedUnit:self.factory.guardian];
	}
}

@end

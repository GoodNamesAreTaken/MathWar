//
//  BuildDecision.m
//  MathWars
//
//  Created by SwinX on 02.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "BuildDecision.h"
#import "Unit.h"

@implementation BuildDecision

+(BuildDecision*)unitOfType:(MWUnitType)unitType atLocation:(Factory*)buildLocation {
	return [[[BuildDecision alloc] initWithUnitType:unitType andLocation:buildLocation] autorelease];
}

-(id)initWithUnitType:(MWUnitType)unitType andLocation:(Factory*)buildLocation {
	if (self = [super init]) {
		location = [buildLocation retain];
		type = unitType;
	}
	return self;
}

-(void)performDecision {
	[location buildUnitOfType:type];
	[decisive newDecision];
}

-(void)dealloc {
	[location release];
	[super dealloc];
}

@end

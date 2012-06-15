//
//  UpgradeDecision.m
//  MathWars
//
//  Created by Inf on 14.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "UpgradeDecision.h"


@implementation UpgradeDecision

+(id)atFactory:(Factory*)factory {
	return [[[UpgradeDecision alloc] initWithFactory:factory] autorelease];
}

-(id)initWithFactory:(Factory*)_factory {
	if (self = [super initWithPlayer:(AIPlayer*)_factory.owner]) {
		factory = [_factory retain];
	}
	return self;
}

-(void)performDecision {
	[factory upgradeGuardian];
	[decisive newDecision];
}

-(void)dealloc {
	[factory release];
	[super dealloc];
}

@end

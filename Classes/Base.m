//
//  Base.m
//  MathWars
//
//  Created by SwinX on 30.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Base.h"
#import "UnitHelper.h"
#import "MapFinisher.h"


@implementation Base
@synthesize baseGuardian;

-(id)init {
	if (self = [super init]) {
		baseGuardian = [[[UnitHelper sharedHelper] getUnit:MWUnitBaseProtector withOwner:self.owner] retain];
	}
	return self;
}

-(void)onUnitEnter:(Unit *)unit {
	if ((self.guardian == nil) && (self.owner == unit.owner)) {
		[unit becomeGuardianOf:self];
	} else if ((self.guardian == nil) && (self.owner != unit.owner)) {
		[Combat startCombatBetweenAttacker:unit andProtector:baseGuardian andDelegate:self];
	} else if (self.guardian != nil && unit.owner != self.owner) {
		[Combat startCombatBetweenAttacker:unit andProtectors:[NSArray arrayWithObjects:self.guardian, baseGuardian, nil] andDelegate:self];
	}	
}

-(void)protectorsBeatenBy:(Unit *)attacker {
}

-(void)userExitedCombat:(Combat *)combat withWinner:(Unit*)winner {
	if (winner.owner != owner) {
		[owner lose];
	}	
}
 
-(void)setOwner:(Player *)newOwner {
	if (owner != newOwner) {
		owner = newOwner;
		baseGuardian.owner = newOwner;
	}
}

-(void)dealloc {
	
	[baseGuardian release];
	[super dealloc];
	
}

@end

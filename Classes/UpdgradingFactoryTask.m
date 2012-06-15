//
//  UpdgradingFactoryTask.m
//  MathWars
//
//  Created by Inf on 30.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "Factory.h"
#import "UpdgradingFactoryTask.h"
#import "UnitHelper.h"

@implementation UpdgradingFactoryTask
@synthesize factory;

-(void)doTask {
	
	int attackBonus = [[UnitHelper sharedHelper] getAttackBonusForUnit:self.factory.guardian.type atUpgrade:self.factory.guardian.upgrades];
	int healthBonus = [[UnitHelper sharedHelper] getHealthBonusForUnit:self.factory.guardian.type atUpgrade:self.factory.guardian.upgrades];
	
	self.factory.guardian.attack += attackBonus;
	self.factory.guardian.maxHealth += healthBonus;
	self.factory.guardian.health = self.factory.guardian.maxHealth;
	
	self.factory.guardian.upgrades++;
	
	NSMutableString* result = [NSMutableString string];
	if (attackBonus > 0) {
		[result appendFormat:@"+%d Attack", attackBonus];
	}
	if (healthBonus > 0) {
		if (attackBonus > 0) {
			[result appendString:@", "];
		}
		[result appendFormat:@"+%d Health", healthBonus];
	}
	
	[self.factory.owner showNotification:result];
	
	if ([factory.delegate respondsToSelector:@selector(factory:upgradedUnit:)]) {
		[factory.delegate factory:factory upgradedUnit:factory.guardian];
	}
	
	[self.factory.guardian unitUpgraded];
	
}

@end

//
//  UnitFactory.m
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "UnitFactory.h"


@implementation UnitFactory

+(UnitFactory*)sharedFactory {
	
	static UnitFactory* instance = nil;
	@synchronized(self) {
		if (instance == nil) {
			instance = [[UnitFactory alloc] init];
		}
	}
	return instance;
}

-(id)init {
	if (self = [super init]) {
		
		//прототип танка
		prototypes[MWUnitTank] = [[Unit alloc] initWithType:MWUnitTank];
		prototypes[MWUnitTank].maxHealth = 1;
		prototypes[MWUnitTank].health = prototypes[MWUnitTank].maxHealth;
		prototypes[MWUnitTank].attack = prototypes[MWUnitTank].maxAttack = 2;
		
		//прототип пулеметчика
		prototypes[MWUnitGunner] = [[Unit alloc] initWithType:MWUnitGunner];
		prototypes[MWUnitGunner].health = prototypes[MWUnitGunner].maxHealth = 3;
		prototypes[MWUnitGunner].attack = prototypes[MWUnitGunner].maxAttack = 1;
		
		//прототип защитника базы
		prototypes[MWUnitBaseProtector] = [[Unit alloc] initWithType:MWUnitBaseProtector];
		prototypes[MWUnitBaseProtector].health = prototypes[MWUnitBaseProtector].maxHealth = 10;
		prototypes[MWUnitBaseProtector].attack = prototypes[MWUnitBaseProtector].maxAttack = 5;
		
	}
	return self;
}

-(Unit*)createUnitOfType:(uint8_t)type withOwner:(Player*) owner {
	return [prototypes[type] copyWithNewOwner:owner];
}

-(void)dealloc {
	for (int i=0; i<MWTotalUnitsCount; i++) {
		[prototypes[i] release];
	}
	[super dealloc];
}

@end

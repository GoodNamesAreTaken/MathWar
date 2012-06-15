//
//  CombatUnitSound.m
//  MathWars
//
//  Created by SwinX on 01.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "CombatUnitSound.h"
#import "UnitHelper.h"
#import "FFGame.h"
#import "PlaySound.h"

@implementation CombatUnitSound

-(id)initWithAttacker:(MWUnitType)attacker andProtector:(MWUnitType)protector {
	if (self = [super init]) {
		attackerStrike = [[[UnitHelper sharedHelper] getAttackSoundNameOfUnit:attacker] retain];
		protectorStrike = [[[UnitHelper sharedHelper] getAttackSoundNameOfUnit:protector] retain];
	}
	return self;
}

-(void)attacker:(Unit*)_attacker strikedProtector:(Unit*)_protector {
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:attackerStrike]];
}

-(void)protector:(Unit*)_protector strikedAttacker:(Unit*)_attacker {
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:protectorStrike]];
}

-(void)protectorChangedFrom:(Unit *)oldProtector to:(Unit *)newProtector {
	[protectorStrike release];
	protectorStrike = [[[UnitHelper sharedHelper] getAttackSoundNameOfUnit:newProtector.type] retain];
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:attackerStrike]];
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:@"unitDied"]];
}

-(void)attackerDeath {
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:protectorStrike]];
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:@"unitDied"]];
}

-(void)protectorsBeatenBy:(Unit *)attacker {
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:attackerStrike]];
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:@"unitDied"]];
}

-(void)dealloc {
	[attackerStrike release];
	[protectorStrike release];
	[super dealloc];
}

@end

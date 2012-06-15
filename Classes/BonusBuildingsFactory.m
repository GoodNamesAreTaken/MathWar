//
//  BounsBuildingsFactory.m
//  MathWars
//
//  Created by SwinX on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "BonusBuildingsFactory.h"
#import "Weaponary.h"
#import "Antenna.h"
#import "Repairer.h"
#import "Sheild.h"

@implementation BonusBuildingsFactory

+(BonusBuildingsFactory*)sharedFactory {
	
	static BonusBuildingsFactory* instance = nil;
	
	@synchronized(self) {	
		if (instance == nil) {
			instance = [[BonusBuildingsFactory alloc] init];
		}
	}
	return instance;
}

-(Building*)createBonusBuildingOfType:(MWMapObjectType)type {
	
	switch (type) {
		case MWMapObjectWeaponary:
			return [[[Weaponary alloc] init] autorelease];
		break;
		case MWMapObjectCoalWarehouse:
			return [[[Antenna alloc] init] autorelease];
		case MWMapObjectRepairer:
			return [[[Repairer alloc] init] autorelease];
		break;
		case MWMapObjectSheild: 
			return [[[Sheild alloc] init] autorelease];
		break;
		default:
			NSLog(@"Unknown bonus building type");
			return nil;
		break;
	}
	
}

@end

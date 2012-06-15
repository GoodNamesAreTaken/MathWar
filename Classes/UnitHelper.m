//
//  UnitHelper.m
//  MathWars
//
//  Created by SwinX on 16.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "UnitHelper.h"

#define PLIST_NAME @"Units"
#define COMBAT_SPRITES @"combatSprites"
#define MAP_SPRITES @"mapSprites"
#define NORMAL_BUTTON_TEXTURE_NAME @"normalBuildButton"
#define PRESSED_BUTTON_TEXTURE_NAME @"normalBuildButton"

@interface UnitHelper(Private)

-(uint8_t)getAttackOf:(MWUnitType)unit;
-(uint8_t)getHealthOf:(MWUnitType)unit;

@end


@implementation UnitHelper

static UnitHelper* instance = nil;

+(UnitHelper*)sharedHelper {
	@synchronized(self) {
		if (instance == nil) {
			instance = [[UnitHelper alloc] init];
		}
	}
	return instance;
}

-(id)init { 
	if (self = [super init]) {
		NSString* path = [[NSBundle mainBundle] pathForResource:PLIST_NAME ofType:@"plist"];
		unitsData = [[NSArray alloc] initWithContentsOfFile:path];
	}
	return self;
}

-(BuildUnitView*)getBuildViewOf:(MWUnitType)unit withBack:(NSString*)backName locked:(BOOL)_locked; {
	
	currentUnitData = [unitsData objectAtIndex:unit];
	return [[[BuildUnitView alloc] initWithButtonNormalTexture:[currentUnitData objectForKey:NORMAL_BUTTON_TEXTURE_NAME] 
			buttonPressedTexture:[currentUnitData objectForKey:PRESSED_BUTTON_TEXTURE_NAME]
			backTexture:backName
			attack:[self getAttackOf:unit] andHealth:[self getHealthOf:unit] locked:_locked] autorelease];
	
}


-(NSString*)getMapTextureOf:(MWUnitType)unitType And:(uint8_t)unitLevel {
	currentUnitData = [unitsData objectAtIndex:unitType];
	return [[currentUnitData objectForKey:MAP_SPRITES] objectAtIndex:unitLevel];
}

-(FFSprite*)getMapSpriteOf:(MWUnitType)unitType And:(uint8_t)unitLevel {
	return [FFSprite spriteWithTextureNamed:[self getMapTextureOf:unitType And:unitLevel]];
}

-(MapUnitView*)getMapViewOf:(MWUnitType)unitType {
	currentUnitData = [unitsData objectAtIndex:unitType];
	return [[[MapUnitView alloc] initWithTextureNamed:[[currentUnitData objectForKey:MAP_SPRITES] objectAtIndex:0]] autorelease];
}

-(CombatUnitView*)getCombatViewOf:(MWUnitType)unitType And:(uint8_t)unitLevel {
	currentUnitData = [unitsData objectAtIndex:unitType];
	return [[[CombatUnitView alloc] initWithSpritesDictionary:[[currentUnitData objectForKey:COMBAT_SPRITES] objectAtIndex:unitLevel]] autorelease]; 
}

-(Unit*)getUnit:(MWUnitType)unit withOwner:(Player*)owner {
	currentUnitData = [unitsData objectAtIndex:unit];

	Unit* newUnit = [[Unit alloc] initWithType:unit];
	newUnit.attack = [self getAttackOf:unit];
	newUnit.health = newUnit.maxHealth = [self getHealthOf:unit];
	newUnit.owner = owner;
	
	return [newUnit autorelease];
}

-(uint8_t)getMinimumLevelForUnit:(MWUnitType)unit withLevel:(uint8_t)unitLevel {
	currentUnitData = [unitsData objectAtIndex:unit];
	return [[[currentUnitData objectForKey:@"availability"] objectAtIndex:unitLevel] unsignedIntValue];
}

-(uint16_t)getTurnsBefore:(MWUnitType)unit {
	currentUnitData = [unitsData objectAtIndex:unit];
	return [[currentUnitData objectForKey:@"turnsBefore"] unsignedIntValue];
}

-(NSString*)getAttackSoundNameOfUnit:(MWUnitType)unit {
	currentUnitData = [unitsData objectAtIndex:unit];
	return [currentUnitData objectForKey:@"attackSound"];
}

-(uint8_t)getAttackOf:(MWUnitType)unit; {
	currentUnitData = [unitsData objectAtIndex:unit];
	NSNumber* attack = [currentUnitData objectForKey:@"attack"];
	return [attack intValue];
}

-(uint8_t)getHealthOf:(MWUnitType)unit {
	currentUnitData = [unitsData objectAtIndex:unit];
	NSNumber* damage = [currentUnitData objectForKey:@"health"];
	return [damage intValue];
}

-(NSString*)getCombatAtlasOf:(MWUnitType)unitType andUnitLevel:(uint8_t)unitLevel {
	currentUnitData = [unitsData objectAtIndex:unitType];
	return [[currentUnitData objectForKey:@"combatAtlases"] objectAtIndex:unitLevel];
}

-(NSString*)getMoveSoundOf:(MWUnitType)unit {
	currentUnitData = [unitsData objectAtIndex:unit];
	return [currentUnitData objectForKey:@"moveSound"];
}

-(uint8_t)unitOpenedAtMission:(int)mission upgrade:(int*)upgrade {
	for (uint8_t type = 0; type < MWUnitBaseProtector; type++) {
		currentUnitData = [unitsData objectAtIndex:type];
		for (int level=0; level < 3; level++) {
			if ([[[currentUnitData objectForKey:@"availability"] objectAtIndex:level] intValue] == mission) {
				*upgrade = level;
				return type;
			}
		}
	}
	return 0xFF;
}

-(int)getAttackBonusForUnit:(MWUnitType)unit atUpgrade:(int)upgrade {
	currentUnitData = [unitsData objectAtIndex:unit];
	return [[[[currentUnitData objectForKey:@"upgrades"] objectAtIndex:upgrade] objectForKey:@"attackBonus"] intValue];
}

-(int)getHealthBonusForUnit:(MWUnitType)unit atUpgrade:(int)upgrade {
	currentUnitData = [unitsData objectAtIndex:unit];
	return [[[[currentUnitData objectForKey:@"upgrades"] objectAtIndex:upgrade] objectForKey:@"healthBonus"] intValue];
}

@end

//
//  UnitHelper.h
//  MathWars
//
//  Created by SwinX on 16.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//


#import "MapUnitView.h"
#import "CombatUnitView.h"
#import "Unit.h"
#import "FFButton.h"
#import "BuildUnitView.h"

@interface UnitHelper : NSObject {
	
	NSArray* unitsData;
	NSDictionary* currentUnitData;
	
}

+(UnitHelper*)sharedHelper;

-(Unit*)getUnit:(MWUnitType)unit withOwner:(Player*)owner;
-(FFSprite*)getMapSpriteOf:(MWUnitType)unitType And:(uint8_t)unitLevel;
-(NSString*)getMapTextureOf:(MWUnitType)unitType And:(uint8_t)unitLevel;
-(MapUnitView*)getMapViewOf:(MWUnitType)unitType;
-(CombatUnitView*)getCombatViewOf:(MWUnitType)unitType And:(uint8_t)unitLevel;
-(BuildUnitView*)getBuildViewOf:(MWUnitType)unit withBack:(NSString*)backName locked:(BOOL)_locked;
-(NSString*)getCombatAtlasOf:(MWUnitType)unitType andUnitLevel:(uint8_t)unitLevel;
-(uint8_t)getMinimumLevelForUnit:(MWUnitType)unit withLevel:(uint8_t)unitLevel;
-(uint16_t)getTurnsBefore:(MWUnitType)unit;
-(NSString*)getAttackSoundNameOfUnit:(MWUnitType)unit;
-(NSString*)getMoveSoundOf:(MWUnitType)unit;

-(int)getAttackBonusForUnit:(MWUnitType)unit atUpgrade:(int)upgrade;
-(int)getHealthBonusForUnit:(MWUnitType)unit atUpgrade:(int)upgrade;
-(uint8_t)unitOpenedAtMission:(int)mission upgrade:(int*)upgrade; 
@end

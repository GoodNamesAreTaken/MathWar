//
//  BuildingView.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "BuildingView.h"
#import "FFGame.h"
#import "GameUI.h"

#define BUILDINGS_PLIST @"Buildings"

@implementation BuildingView

+(BuildingView*)viewOfType:(MWMapObjectType)type {
	
	
	NSString* path = [[NSBundle mainBundle] pathForResource:BUILDINGS_PLIST ofType:@"plist"];
	NSDictionary* buildingSpriteArrays = [[[NSDictionary alloc] initWithContentsOfFile:path] autorelease];//[[NSArray alloc] initWithContentsOfFile:path];
	
	switch (type) {
			
		case MWMapObjectBase:
			return [[[BuildingView alloc] initWithBuildingTextures:[buildingSpriteArrays objectForKey:@"base"] andPlatformTexture:@"basePlatform.png"] autorelease];
		break;
		case MWMapObjectFactory:
			return [[[BuildingView alloc] initWithBuildingTextures:[buildingSpriteArrays objectForKey:@"factory"] andPlatformTexture:@"factoryPlatform.png"] autorelease];
		break;			
		case MWMapObjectWeaponary:
			return [[[BuildingView alloc] initWithBuildingTextures:[buildingSpriteArrays objectForKey:@"weaponary"] andPlatformTexture:@"weaponaryPlatform.png"] autorelease];
		break;
		case MWMapObjectCoalWarehouse:
			return [[[BuildingView alloc] initWithBuildingTextures:[buildingSpriteArrays objectForKey:@"coalWarehouse"] andPlatformTexture:@"coalWarehousePlatform.png"] autorelease];
		break;
		case MWMapObjectRepairer:
			return [[[BuildingView alloc] initWithBuildingTextures:[buildingSpriteArrays objectForKey:@"repairer"] andPlatformTexture:@"repairerPlatform.png"] autorelease];
		break;
		case MWMapObjectSheild:
			return [[[BuildingView alloc] initWithBuildingTextures:[buildingSpriteArrays objectForKey:@"sheild"] andPlatformTexture:@"sheildPlatform.png"] autorelease];
		break;

		default:
			NSLog(@"Unknown bonus building type %d", type);
			return nil;
		break;
	}	
	
}

-(id)initWithBuildingTextures:(NSArray*)buildingTextures andPlatformTexture:(NSString*)platformTexture {
	if (self = [super init]) {
		
		buildingSprite = [[AnimatedSpriteWithInterval alloc] initWithFrameNames:buildingTextures];
		ownIndicator = [[OwnIndicator alloc] initWithNeutralTexture:platformTexture];
		
		buildingSprite.layer = 0;
		
		buildingSprite.x = -0.5f*buildingSprite.width;
		buildingSprite.y = -0.5f*buildingSprite.height;
		
		[buildingSprite playFramesFrom:0 to:buildingTextures.count-1 withDelay:0.1f];
		ownIndicator.layer = 0;
		
		[self addChild:buildingSprite];
		[self addChild:ownIndicator];
	}
	
	return self;
}

-(float)panelX {
	return self.x + ownIndicator.x;
}

-(float)panelY {
	return self.y + ownIndicator.y;
}

-(void)becomeNeutral {
	[ownIndicator becomeNeutral];
}

-(void)becomePlayer {
	[ownIndicator becomeOur];
}

-(void)becomeEnemy {
	[ownIndicator becomeEnemy];
}

-(void)dealloc {
	[buildingSprite release];
	[ownIndicator release];
	[super dealloc];
}

@end

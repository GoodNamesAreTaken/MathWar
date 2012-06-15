//
//  GameUI.m
//  MathWars
//
//  Created by Inf on 16.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "GameUI.h"
#import "MapLoader.h"
#import "BuildingView.h"
#import "FFGame.h"
#import "FactoryController.h"
#import "Swamp.h"
#import "Gorge.h"
#import "MineField.h"
#import "Weaponary.h"
#import "Antenna.h"
#import "Repairer.h"
#import "Sheild.h"
#import "MapController.h"
#import "Base.h"
#import "Barricades.h"
#import "FFTexturedLine.h"
#import "BackgroundRenderer.h"
#import "BGSoundSheduler.h"
 
#define GARBAGE_TO_ADD 65

@interface GameUI(Private)
-(void)addViewControllerOfBuilding:(MapObject*)object andType:(MWMapObjectType)type;
-(void)addRandomGarbage;
@end
 
static GameUI* instance;
@implementation GameUI
@synthesize mapView, lock, panel, textPanel;

+(GameUI*)sharedUI {
	@synchronized(instance) {
		if (instance == nil) {
			instance = [[GameUI alloc] init];
		}
	}
	return instance;
}

-(id)init {
	if (self = [super init]) {
		lock = [[MapLock alloc] init];
		
		panel = [[ActionsPanel alloc] init];
		panel.layer = 100;
		
		textPanel = [[TextPanel alloc] init];
		textPanel.layer = 100;
		
		lines = [[NSMutableArray alloc] init];
		
	}
	return self;
}

-(void)buildMapViewForPlayer:(Player*)player andEnemy:(Player*)enemy {
	[lock setDefault];
	if (mapView) {
		[mapView release];
		mapView = nil;
	}
	
	mapView = [[MapView alloc] init];
	BackgroundRenderer* backgroundRenderer = [BackgroundRenderer renderer];
	
	[backgroundRenderer createTilesPerX:8 perY:8];
	
	for (int i=0; i<GARBAGE_TO_ADD; i++) {
		[backgroundRenderer addGarbage];
	}
	
	for (int i=0; i<[MapLoader sharedLoader].mapTemplate->objectCount; i++) {
		for (int j=i+1; j<[MapLoader sharedLoader].mapTemplate->objectCount; j++) {
			
			if ([MapLoader sharedLoader].mapTemplate->roadsGraph[i][j]) {
				[backgroundRenderer addRoadFromX:[MapLoader sharedLoader].mapTemplate->objects[i].x
											   y:[MapLoader sharedLoader].mapTemplate->objects[i].y
											   toX:[MapLoader sharedLoader].mapTemplate->objects[j].x
											   y:[MapLoader sharedLoader].mapTemplate->objects[j].y];
			}
		}
	}
	
	[[FFGame sharedGame] addController:[MapController controllerForView:mapView]];
	for (MapObject* object in [MapLoader sharedLoader].map) {
		
		FFSprite* obstacleView = nil;
		
		if ([object isKindOfClass:[Swamp class]]) {
			obstacleView = [FFSprite spriteWithTextureNamed:@"swamp.png"];
		} else if ([object isKindOfClass:[MineField class]]) {
			obstacleView = [FFSprite spriteWithTextureNamed:@"MineField.png"];
		} else if ([object isKindOfClass:[Gorge class]]) {
			obstacleView = [FFSprite spriteWithTextureNamed:@"gorge.png"];
		} else if ([object isKindOfClass:[Barricades class]]) {
			obstacleView = [FFSprite spriteWithTextureNamed:@"barricades.png"];
			
		} else if ([object isKindOfClass:[Base class]]) {
				[self addViewControllerOfBuilding:object andType:MWMapObjectBase];
		} else if ([object isKindOfClass:[Factory class]]) {
				[self addViewControllerOfBuilding:object andType:MWMapObjectFactory];
		} else if ([object isKindOfClass:[Weaponary class]]) {
			[self addViewControllerOfBuilding:object andType:MWMapObjectWeaponary];
		} else if ([object isKindOfClass:[Antenna class]]) {
			[self addViewControllerOfBuilding:object andType:MWMapObjectCoalWarehouse];
		} else if ([object isKindOfClass:[Repairer class]]) {
			[self addViewControllerOfBuilding:object andType:MWMapObjectRepairer];
		} else if ([object isKindOfClass:[Sheild class]]) {
			[self addViewControllerOfBuilding:object andType:MWMapObjectSheild];
		}

		if (obstacleView) {
			obstacleView.layer = 1;
			[[FFGame sharedGame] addController:[MapObjectController controllerWithModel:object andView:obstacleView]];
			[mapView addChild:obstacleView];	
		}
		
	}
	
	[mapView createBackgroundFromTexture:[backgroundRenderer createTexture]];
	[[FFGame sharedGame] addController:[[[BGSoundSheduler alloc] init] autorelease]];
	[self showGame];
}

-(void)destroyMap {
	[mapView hide];
	[mapView release];
	mapView = nil;
}

-(void)showGame {
	[mapView show];
	[panel show];
	[textPanel show];
}

-(void)hideGame {
	[mapView hide];
	[panel hide];
	[textPanel hide];
}

-(void)addViewControllerOfBuilding:(Building*)object andType:(MWMapObjectType)type {

	Player* player = [[FFGame sharedGame] getModelByName:@"player"];
	Player* enemy = [[FFGame sharedGame] getModelByName:@"enemy"];
	
	BuildingView* view = [BuildingView viewOfType:type];
	view.layer = 1;
	
	if (object.owner == player) {
		[view becomePlayer];
		[object onOwnerChange:player];
		if (type == MWMapObjectBase) {
			[mapView scrollToX:object.x	y:object.y];
		}
		
	} else if (object.owner == enemy) {
		[view becomeEnemy];
	}
	
	if (type == MWMapObjectBase || type == MWMapObjectFactory) {
		[[FFGame sharedGame] addController:[FactoryController controllerWithModel:object andView:view]];
	} else {
		[[FFGame sharedGame] addController:[BuildingController controllerWithModel:object andView:view]];
	}
	
	[mapView addChild:view];	
}

-(void)dealloc {
	[mapView release];
	[lock release];
	[panel release];
	[lines release];
	[super dealloc];
}

@end

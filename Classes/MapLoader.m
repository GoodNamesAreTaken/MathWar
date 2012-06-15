//
//  MapLoader.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Factory.h"
#import "MapLoader.h"
#import "ObstacleFactory.h"
#import "Obstacle.h"
#import "Player.h"
#import "BonusBuildingsFactory.h"
#import "FFNeighboursCreator.h"
#import "RandomMapPlacer.h"
#import "Base.h"
#import "LineOperations.h"

#define BASES_COUNT 2

#define OBSTACLES_TO_INSERT 5


@interface MapLoader(Private)

-(void)createRandomParamsWith:(int)factories and:(int)bonuses;
-(void)createMapObjectsFromParams:(MWNetWorkMapParams*)params andPlayer:(Player*)player andEnemy:(Player*)enemy;
-(void)createRoadsFromParams:(MWNetWorkMapParams*)params;

@end

@implementation MapLoader
@synthesize map = mapObjects;

+(MapLoader*)sharedLoader {
	
	static MapLoader* instance = nil;
	
	@synchronized(self) {
		if (instance == nil) {
			instance = [[MapLoader alloc] init];
		}
	}
	return instance;
}

-(void)loadRandomWithObjectCount:(uint32_t)objectCount player:(Player*)player andEnemy:(Player*)enemy; {

	memset(&mapParams, 0, sizeof(MWNetWorkMapParams));
	
	RandomMapPlacer* placer = [[[RandomMapPlacer alloc] initWithTemplate:&mapParams] autorelease];
	[placer createMapWithObjectCount:objectCount];
	
	[self loadFromNetworkParams:&mapParams withPlayer:player andEnemy:enemy];
}

-(void)loadFromNetworkParams:(MWNetWorkMapParams*)params withPlayer:(Player*)player andEnemy:(Player*)enemy {
	mapParams = *params;
	[mapObjects release];
	mapObjects = [[NSMutableArray alloc] init];
	
	[self createMapObjectsFromParams:params andPlayer:player andEnemy:enemy];
	[self createRoadsFromParams:params];
		
} 


-(void)createMapObjectsFromParams:(MWNetWorkMapParams*)params andPlayer:(Player*)player andEnemy:(Player*)enemy {
	for (uint32_t i=0; i<params->objectCount; i++) {
		
		MapObject* object;
		
		switch (params->objects[i].type) {
			case MWMapObjectBase:
				object = [[[Base alloc] init] autorelease];
				break;
				
			case MWMapObjectFactory:
				object = [[[Factory alloc] init] autorelease];
				break;
				
		
			case MWMapObjectGorge:
			case MWMapObjectMineField:
			case MWMapObjectSwamp:
			case MWMapObjectBarricades:
				object = [[ObstacleFactory sharedFactory] createObstacleOfType:params->objects[i].type];
				break;
			case MWMapObjectWeaponary:
			case MWMapObjectCoalWarehouse:
			case MWMapObjectRepairer:
			case MWMapObjectSheild:
				object = [[BonusBuildingsFactory sharedFactory] createBonusBuildingOfType:params->objects[i].type];
				break;
			default:
				NSLog(@"Invalid map object");
				return;
		}
		
		object.objectId = i;
		object.x = params->objects[i].x;
		object.y = params->objects[i].y;
		[mapObjects addObject:object];
		
		if ([object isKindOfClass:[Building class]]) {
			
			if (params->objects[i].owner == 1) {
				((Building*)object).owner = player;
				
				if ([object isKindOfClass:[Factory class]]) {
					[player assignFactory:(Factory*)object];
				}
			
			} else if (params->objects[i].owner == 2 ){
				((Building*)object).owner = enemy;
				if ([object isKindOfClass:[Factory class]]) {
					[enemy assignFactory:(Factory*)object];
				}
			}
			
		}
		
	}	
}


-(void)createRoadsFromParams:(MWNetWorkMapParams*)params {
	
	for (int i=0; i<mapObjects.count; i++) {
		MapObject* object = [mapObjects objectAtIndex:i];
		for (int j=0; j<mapObjects.count; j++) {
			
			if (params->roadsGraph[i][j] && i != j) {
				if (![object.neighbours containsObject:[mapObjects objectAtIndex:j]]) {
					[object.neighbours addObject:[mapObjects objectAtIndex:j]];
				}
			}
		}
	}
	
}

-(MWNetWorkMapParams*)mapTemplate {
	return &mapParams;
}

-(MapObject*)getMapObjectByID:(uint8_t)objectID {
	for (MapObject* mapObject in mapObjects) {
		if (mapObject.objectId == objectID) {
			return mapObject;
		}
	}
	return nil;
}

-(void)loadFromFile:(NSString *)fileName withPlayer:(Player*)player andEnemy:(Player*)enemy {
	NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mwm"];
	
	FILE* f = fopen([path UTF8String], "rb");
	fseek(f, 3, SEEK_SET);
	
	//UInt32 pointer = 3;//пропускаем MWM
	memset(&mapParams, 0, sizeof(MWNetWorkMapParams));
	
	fread(&mapParams.objectCount, sizeof(int32_t), 1, f);
	mapParams.objectCount = CFSwapInt32(mapParams.objectCount);
	
	
	for (int i=0; i<mapParams.objectCount; i++) {
		fread(&mapParams.objects[i].type, sizeof(int8_t), 1, f);
		fread(&mapParams.objects[i].owner, sizeof(uint8_t), 1, f);
		CFSwappedFloat32 swappedX;
		fread(&swappedX, sizeof(CFSwappedFloat32), 1, f);
		mapParams.objects[i].x = CFConvertFloat32SwappedToHost(swappedX);
		CFSwappedFloat32 swappedY;
		fread(&swappedY, sizeof(CFSwappedFloat32), 1, f);
		mapParams.objects[i].y = CFConvertFloat32SwappedToHost(swappedY);
		
	}
	//дороги
	int32_t roadsCount;
	fread(&roadsCount, sizeof(int32_t), 1, f);
	roadsCount = CFSwapInt32(roadsCount);
	
	for (int i=0; i<roadsCount; i++) {
		int32_t first;
		int32_t second;
		fread(&first, sizeof(int32_t), 1, f);
		first = CFSwapInt32(first);
		fread(&second, sizeof(int32_t), 1, f);
		second = CFSwapInt32(second);
		mapParams.roadsGraph[first][second] = mapParams.roadsGraph[second][first] = YES;
	}
	fclose(f);
	[self loadFromNetworkParams:&mapParams withPlayer:player andEnemy:enemy];
	
}

-(void)destroyMap {
	for (MapObject* object in mapObjects) {
		[object cleanAllRoads];
	}
	[mapObjects release];
	mapObjects = nil;
}


-(void)dealloc {
	[mapObjects release];
	[super dealloc];
}

@end

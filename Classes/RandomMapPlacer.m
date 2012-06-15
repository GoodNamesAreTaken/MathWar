//
//  RandomMapCell.m
//  MathWars
//
//  Created by Inf on 24.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "RandomMapPlacer.h"
#import "NetworkProtocol.h"
#import "LineOperations.h"


@interface RandomMapPlacer(Private)
-(void)placeObject:(MWNetworkMapObject*)object intoCellX:(int)cellX cellY:(int)cellY;
-(MWMapObjectType)negativeObjectType;
-(MWMapObjectType)positiveObjectType;
-(int)nearestTo:(int)source distance:(float*)pDistance;
-(int)nearestToTree:(NSArray*)tree graphVertex:(int*)pGraphVertex andDistance:(float*)pDistance;
-(void)addRoadBetween:(int)first :(int)second withObstacle:(BOOL)obstacle;
@end



@implementation RandomMapPlacer

-(id)initWithTemplate:(MWNetWorkMapParams*)params {
	if (self = [super init]) {
		mapTemplate = params;
		for (int i=0; i<7; i++) {
			for (int j=0; j<7; j++) {
				cells[i][j] = YES;
			}
		}
	}
	return self;
}

-(void)createMapWithObjectCount:(uint32_t)objectCount {
	objectCount = MIN(objectCount, MAX_MAP_OBJECTS);
	
	cells[0][0] = cells[0][6] = cells[6][0] = cells[6][6] = NO;
	for (int i=0; i<objectCount; i++) {
		[self addObject];
	}
	[self createRoads];
	
	cells[0][0] = cells[0][6] = cells[6][0] = cells[6][6] = YES;
	[self addBaseWithOwner:1];
	[self addBaseWithOwner:2];
}

-(void)addBaseWithOwner:(int)owner {
	int xCell, yCell;
	do {
		int corner = arc4random() % 4;
		switch (corner) {
			case 0:
				xCell = 0;
				yCell = 0;
				break;
			case 1:
				xCell = 6;
				yCell = 6;
			case 2:
				xCell = 0;
				yCell = 6;
				break;
			default:
				xCell = 6;
				yCell = 0;
				break;
		}
	} while (cells[xCell][yCell] == NO);
	
	int baseId = mapTemplate->objectCount;
	mapTemplate->objectCount++;
	
	mapTemplate->objects[baseId].type = MWMapObjectBase;
	mapTemplate->objects[baseId].owner = owner;
	
	[self placeObject: &mapTemplate->objects[baseId] intoCellX:xCell	cellY:yCell];
	
	float distance;
	int roadTo = [self nearestTo:baseId distance:&distance];
	
	[self addRoadBetween:baseId :roadTo withObstacle:distance > 2 * CELL_SIZE && mapTemplate->objectCount < MAX_MAP_OBJECTS];
	
}

-(void)addObject {
	int xCell, yCell;
	do {
		xCell = arc4random() % 7;
		yCell = arc4random() % 7;
	} while (cells[xCell][yCell] == NO);
	
	int objectId = mapTemplate->objectCount;
	mapTemplate->objectCount++;
	
	
	mapTemplate->objects[objectId].type = [self positiveObjectType];
	
	[self placeObject:&mapTemplate->objects[objectId] intoCellX:xCell cellY:yCell];
}

-(void)createRoads {
	
	int initial = arc4random() % mapTemplate->objectCount;
	NSMutableArray* graphVertices = [NSMutableArray arrayWithObject:[NSNumber numberWithInt:initial]];
                                                                                                                                                                                                       	
	while (graphVertices.count != mapTemplate->objectCount) {
		int graphVertex;
		float distance;
		int newVertex = [self nearestToTree:graphVertices graphVertex:&graphVertex andDistance:&distance];
		
		BOOL needObstacle = distance > 2*CELL_SIZE && mapTemplate->objectCount < MAX_MAP_OBJECTS;
		[self addRoadBetween:newVertex :graphVertex withObstacle:needObstacle];
		
		if (needObstacle) {
			//добавим вершину препятствия к графу
			[graphVertices addObject:[NSNumber numberWithInt:mapTemplate->objectCount - 1]];
		}
		
		[graphVertices addObject:[NSNumber numberWithInt:newVertex]];
	}
}

@end

@implementation RandomMapPlacer(Private)

-(void)addRoadBetween:(int)first :(int)second withObstacle:(BOOL)obstacle {
	if (!obstacle) {
		mapTemplate->roadsGraph[first][second] = YES;
		mapTemplate->roadsGraph[second][first] = YES;
	} else {// if (mapTemplate->objectCount < MAX_MAP_OBJECTS){
		int obstacleVertex = mapTemplate->objectCount;
		mapTemplate->objectCount++;
		mapTemplate->objects[obstacleVertex].type = [self negativeObjectType];
		mapTemplate->objects[obstacleVertex].x = (mapTemplate->objects[first].x + mapTemplate->objects[second].x) * 0.5f;
		mapTemplate->objects[obstacleVertex].y = (mapTemplate->objects[first].y + mapTemplate->objects[second].y) * 0.5f;
				
		
		mapTemplate->roadsGraph[first][obstacleVertex] = YES;
		mapTemplate->roadsGraph[obstacleVertex][first] = YES;
		
		mapTemplate->roadsGraph[obstacleVertex][second] = YES;
		mapTemplate->roadsGraph[second][obstacleVertex] = YES;
	}
}

-(void)placeObject:(MWNetworkMapObject*)object intoCellX:(int)cellX cellY:(int)cellY {
	object->x = cellX*CELL_SIZE + CELL_SIZE*0.5f;
	object->y = cellY*CELL_SIZE + CELL_SIZE*0.5f;
	cells[cellX][cellY] = NO;
}

-(int)nearestToTree:(NSArray*)tree graphVertex:(int*)pGraphVertex andDistance:(float*)pDistance{
	int nearestVertex = *pGraphVertex = -1;
	*pDistance = INFINITY;
	
	for (NSNumber* vertex in tree) {
		int sourceVertex = [vertex intValue];
		for (int i=0; i<mapTemplate->objectCount; i++) {
			if ([tree containsObject:[NSNumber numberWithInt:i]]) {
				continue;
			}
			
			float distance = [LineOperations lengthOfX1:mapTemplate->objects[sourceVertex].x X2:mapTemplate->objects[i].x Y1:mapTemplate->objects[sourceVertex].y Y2:mapTemplate->objects[i].y];
			if (distance < *pDistance) {
				*pDistance = distance;
				nearestVertex = i;
				*pGraphVertex = sourceVertex;
			}
		}
	}
	return nearestVertex;
}

-(MWMapObjectType)positiveObjectType {
	int objectId = arc4random() % 5;
	switch (objectId) {
		case 0:
			return MWMapObjectFactory;
		case 1:
			return MWMapObjectRepairer;
		case 2:
			return MWMapObjectWeaponary;
		case 3:
			return MWMapObjectSheild;
		default:
			return MWMapObjectCoalWarehouse;
	}
}

-(MWMapObjectType)negativeObjectType {
	return MWMapObjectBarricades + arc4random() % 4;
}

-(int)nearestTo:(int)source distance:(float*)pDistance {
	int nearest = -1;
	*pDistance = INFINITY;
	for (int i=0; i<mapTemplate->objectCount; i++) {
		if (i == source || mapTemplate->roadsGraph[i][source] || mapTemplate->objects[i].type == MWMapObjectBase) {
			continue;
		}
		
		float distance = [LineOperations lengthOfX1:mapTemplate->objects[source].x X2:mapTemplate->objects[i].x Y1:mapTemplate->objects[source].y Y2:mapTemplate->objects[i].y];
		if (distance < *pDistance) {
			*pDistance = distance;
			nearest = i;
		}
	}
	return nearest;
}

@end
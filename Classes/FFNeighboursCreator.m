//
//  PrimaAlhoritm.m
//  MathWars
//
//  Created by SwinX on 26.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFNeighboursCreator.h"
#import "NetworkProtocol.h" 
#import "MapObject.h"
#import "FFRib.h"
#import "ObstacleFactory.h"

@interface FFNeighboursCreator(Private)

-(void)createTempRibsToTreeFromVertex:(MapObject*)newVertex;
-(FFRib*)getMinimalRibFromTempRibs;
-(void)shuffleInitialObjects;

@end

@implementation FFNeighboursCreator

-(id)initWithMapParams:(MWNetWorkMapParams*)params {
	
	if (self = [super init]) {
		
		localParams = params;
		
		initialVerticies = [[NSMutableArray alloc] init];
		
		for (int i=0; i<params->objectCount; i++) {
			MapObject* vertex = [[[MapObject alloc] init] autorelease];
			vertex.x = localParams->objects[i].x;
			vertex.y = localParams->objects[i].y;
			vertex.objectId = i;
			[initialVerticies addObject: vertex];
		}
		
		ribs = [[NSMutableArray alloc] init];
		addedVeriticies = [[NSMutableArray alloc] init];
		temporaryRibs = [[NSMutableArray alloc] init];
		
		[self shuffleInitialObjects];
		
	}
	return self;
	
}

-(void)createSkeleton {
	
	MapObject* currentVertex = [initialVerticies objectAtIndex:0];
	[addedVeriticies addObject:currentVertex];
	
	for (int i = 1; i < initialVerticies.count; i++) {
		[temporaryRibs removeAllObjects];
		currentVertex = [initialVerticies objectAtIndex:i];
		[self createTempRibsToTreeFromVertex:currentVertex];
		[ribs addObject:[self getMinimalRibFromTempRibs]];
		[addedVeriticies addObject:currentVertex];
	}	
	
	for (FFRib* rib in ribs) {
		localParams->roadsGraph[rib.firstVertex.objectId][rib.secondVertex.objectId] = YES;
		localParams->roadsGraph[rib.secondVertex.objectId][rib.firstVertex.objectId] = YES;
	}
			
}

-(void)shuffleInitialObjects { 
	
	for (int i=0; i<initialVerticies.count/2 ; i++) {
		int firstIndex = arc4random()%(initialVerticies.count-1);
		int secondIndex = arc4random()%(initialVerticies.count-1);
		[initialVerticies exchangeObjectAtIndex:firstIndex withObjectAtIndex:secondIndex];
	}
	
}

-(void)createTempRibsToTreeFromVertex:(MapObject*)newVertex {
	for (MapObject* vertex in addedVeriticies) {
		[temporaryRibs addObject:[FFRib ribBetween:vertex and:newVertex]];
	}	
}

-(FFRib*)getMinimalRibFromTempRibs {
	FFRib* minimal = [temporaryRibs objectAtIndex:0];
	for (int i=1; i<temporaryRibs.count; i++) {
		if (((FFRib*)[temporaryRibs objectAtIndex:i]).length < minimal.length) {
			minimal = [temporaryRibs objectAtIndex:i];
		}
	}
	return minimal;	
}


-(void)dealloc {
	[initialVerticies release];
	[ribs release];
	[temporaryRibs release];
	[addedVeriticies release];
	[super dealloc];
}

@end

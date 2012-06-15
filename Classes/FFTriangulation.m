//
//  Triangulation.m
//  MathWars
//
//  Created by SwinX on 25.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFTriangulation.h"
#import "FFTriangle.h"
#import "FFRib.h"

@interface FFTriangulation(Private)

-(void)createTriangulation;
-(void)createMinimalSkeleton;
-(void)addRibsFromTriangle:(FFTriangle*)triangle;

@end

@implementation FFTriangulation

-(id)initWithMapObjects:(NSMutableArray*)mapObjects {
	
	if (self = [super init]) {
		initialObjects = [mapObjects retain];
		triangles = [[NSMutableArray alloc] init];;
	}
	return self;
	
}

-(void)createNeighbourhood {
	[self createTriangulation];
	[self createMinimalSkeleton];
}

-(void)setUp {
	
	firstStarting = [[MapObject alloc] init];
	firstStarting.x = 0.0f;
	firstStarting.y = 0.0f;
	secondStarting = [[MapObject alloc] init];
	secondStarting.x = 320.0f;
	secondStarting.y = 0.0f;
	thirdStarting = [[MapObject alloc] init];
	thirdStarting.x = 0.0f;
	thirdStarting.y = 480.0f;
	fourthStarting = [[MapObject alloc] init];
	fourthStarting.x = 320.0f;
	fourthStarting.y = 480.0f;
	
	MapObject* initialVertex = [initialObjects objectAtIndex:0];
	
	FFTriangle* firstStartingTriangle = [[[FFTriangle alloc] initWithFirstVertex:firstStarting andSecondVertex:initialVertex andThirdVertex:secondStarting] autorelease];
	FFTriangle* secondStartingTriangle = [[[FFTriangle alloc] initWithFirstVertex:secondStarting andSecondVertex:initialVertex andThirdVertex:fourthStarting] autorelease];
	FFTriangle* thirdStartingTriangle = [[[FFTriangle alloc] initWithFirstVertex:thirdStarting andSecondVertex:initialVertex andThirdVertex:fourthStarting] autorelease];
	FFTriangle* fourthStartingTriangle = [[[FFTriangle alloc]initWithFirstVertex:firstStarting andSecondVertex:initialVertex andThirdVertex:thirdStarting] autorelease];
	
	[triangles addObject:firstStartingTriangle];
	[triangles addObject:secondStartingTriangle];
	[triangles addObject:thirdStartingTriangle];
	[triangles addObject:fourthStartingTriangle];
	
}

-(void)createTriangulation {
	
	[self setUp];
	
	MapObject* currentVertex;
	
	for (int i=1; i<initialObjects.count; i++) {
		currentVertex = [initialObjects objectAtIndex:i];
		
		NSArray* trianglesCopy = [triangles copy];
		for (FFTriangle* triangle in trianglesCopy) {
			if ([triangle vertexInside:currentVertex]) {
				[triangles addObject:[[[FFTriangle alloc] initWithFirstVertex:currentVertex andSecondVertex:triangle.firstVertex andThirdVertex:triangle.secondVertex] autorelease]];
				[triangles addObject:[[[FFTriangle alloc] initWithFirstVertex:currentVertex andSecondVertex:triangle.secondVertex andThirdVertex:triangle.thirdVertex] autorelease]];
				[triangles addObject:[[[FFTriangle alloc] initWithFirstVertex:currentVertex andSecondVertex:triangle.thirdVertex andThirdVertex:triangle.firstVertex] autorelease]];
				[triangles removeObject: triangle];
				break;
			}
		}
		
		[trianglesCopy release];
		trianglesCopy = nil;
		
	}
	
	for (FFTriangle* triangle in triangles) {
		[triangle linkMapObjects];
		[triangle removeMapObjectFromVertexNeighbours:firstStarting];
		[triangle removeMapObjectFromVertexNeighbours:secondStarting];
		[triangle removeMapObjectFromVertexNeighbours:thirdStarting];
		[triangle removeMapObjectFromVertexNeighbours:fourthStarting];
	}
	
}

-(void)dealloc {

	[initialObjects release];
	[triangles release];
	[firstStarting release];
	[secondStarting release];
	[thirdStarting release];
	[fourthStarting release];
	[super dealloc];
	
}

@end

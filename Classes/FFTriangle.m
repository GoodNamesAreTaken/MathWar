//
//  Triangle.m
//  MathWars
//
//  Created by SwinX on 24.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFTriangle.h"

@interface FFTriangle(Private)

-(int)wherePointNearRibAx:(int)ax Ay:(int)Ay Bx:(int)bx By:(int)by Px:(int)px Py:(int)py;

@end


@implementation FFTriangle

@synthesize firstVertex, secondVertex, thirdVertex;
@synthesize firstRib, secondRib, thirdRib;

-(id)initWithFirstVertex:(MapObject*)_firstVertex andSecondVertex:(MapObject*)_secondVertex andThirdVertex:(MapObject*)_thirdVertex {
	
	if (self = [super init]) {
		
		firstVertex = [_firstVertex retain];
		secondVertex = [_secondVertex retain];
		thirdVertex = [_thirdVertex retain];
		
		firstRib = [[FFRib alloc] initWithFirstVertex:firstVertex andSecondVertex:secondVertex];
		secondRib = [[FFRib alloc] initWithFirstVertex:secondVertex andSecondVertex:thirdVertex];
		thirdRib = [[FFRib alloc] initWithFirstVertex:thirdVertex andSecondVertex:firstVertex];
		
	}
	return self;
}

-(BOOL)vertexInside:(MapObject *)vertex {
	
	int firstDirection = [self wherePointNearRibAx:firstVertex.x Ay:firstVertex.y Bx:secondVertex.x By:secondVertex.y Px:vertex.x Py:vertex.y];
	int secondDirection = [self wherePointNearRibAx:secondVertex.x Ay:secondVertex.y Bx:thirdVertex.x By:thirdVertex.y Px:vertex.x Py:vertex.y];
	if (firstDirection*secondDirection <= 0) {
		return NO;
	}
	int thirdDirection = [self wherePointNearRibAx:thirdVertex.x Ay:thirdVertex.y Bx:firstVertex.x By:firstVertex.y Px:vertex.x Py:vertex.y];
	if (thirdDirection*secondDirection <= 0) {
		return NO;
	}
	return YES;
}

-(int)wherePointNearRibAx:(int)ax Ay:(int)ay Bx:(int)bx By:(int)by Px:(int)px Py:(int)py {

	float direction = (bx-ax)*(py-ay)-(by-ay)*(px-ax);
	if (direction > 0) {
		return 1;
	} else if (direction < 0) {
		return -1;
	} else {
		return 0;
	}
	
}

-(void)linkMapObjects {

	[firstRib linkMapObjects];
	[secondRib linkMapObjects];
	[thirdRib linkMapObjects];

}

-(void)removeMapObjectFromVertexNeighbours:(MapObject*)mapObject {
	[firstVertex.neighbours removeObject:mapObject];
	[secondVertex.neighbours removeObject:mapObject];
	[thirdVertex.neighbours removeObject:mapObject];	
}

-(void)dealloc {
	[firstVertex release];
	[secondVertex release];
	[thirdVertex release];
	[super dealloc];
}

@end

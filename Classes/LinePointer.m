//
//  LinePointer.m
//  MathWars
//
//  Created by SwinX on 06.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "LinePointer.h"
#import "FFRib.h"
#import "LineOperations.h"

#import "GameUI.h"

#define PI 3.14
#define PART_SIDE 10.0f

@implementation LinePointer

-(id)initWithStartObject:(MapObject*)startObject andEndObject:(MapObject*)endObject {
	
	if (self = [super init]) {
		start = [startObject retain];
		end = [endObject retain];
		length = [FFRib getLengthBetweenFirstVerticies:start andSecondVertex:end];
		sprites = [[NSMutableArray alloc] init];
		
		
		int partsAmount = length / PART_SIDE;
				
		for (float i=1; i<partsAmount+1; i++) {
			
			float step = i/partsAmount;
		
			FFSprite* linePart = [FFSprite spriteWithTextureNamed:@"lineBlock.png"];
			linePart.x = [LineOperations interpolationOfFirstPoint:startObject.x andSecondPoint:endObject.x withStep:step];
			linePart.y = [LineOperations interpolationOfFirstPoint:startObject.y andSecondPoint:endObject.y withStep:step];
			linePart.layer = 3;
			[sprites addObject:linePart];
			[self addChild:linePart];
			
		}
		
	}
	return self;
}

-(float)getAngleToRotate {
	float k = (end.y  - start.y) / (end.x - start.x);
	float angle = k * 180 / PI;
	return angle;
}

-(void)dealloc {
	[start release];
	[end release];
	[sprites release];
	[super dealloc];
}

@end

//
//  triangleRib.m
//  MathWars
//
//  Created by SwinX on 25.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFRib.h"
#import "LineOperations.h"


@implementation FFRib

@synthesize firstVertex, secondVertex;
@synthesize length;

+(id)ribBetween:(MapObject*)first and:(MapObject*)second {
	return [[[FFRib alloc] initWithFirstVertex:first andSecondVertex:second] autorelease];
}

+(float)getLengthBetweenFirstVerticies:(MapObject*)_firstVertex andSecondVertex:(MapObject*)_secondVertex {
	return [LineOperations lengthOfX1:_firstVertex.x X2:_secondVertex.x Y1:_firstVertex.y Y2:_secondVertex.y];
}

-(id)initWithFirstVertex:(MapObject*)_firstVertex andSecondVertex:(MapObject*)_secondVertex {
	
	if (self = [super init]) {
		firstVertex = [_firstVertex retain];
		secondVertex = [_secondVertex retain];
		
		length = abs(sqrt(pow(secondVertex.x - firstVertex.x ,2) + pow(secondVertex.y - firstVertex.y,2)));
	}
	return self;
	
}

-(void)linkMapObjects {
	
	if (![firstVertex.neighbours containsObject:secondVertex]) {
		[firstVertex.neighbours addObject:secondVertex];
	}
	
	if (![secondVertex.neighbours containsObject:firstVertex]) {
		[secondVertex.neighbours addObject:firstVertex];
	}
	
}

-(MapObject*)getConnectedVertexFor:(MapObject*)vertex {
	
	if (vertex == firstVertex) {
		return secondVertex;
	} else if (vertex == secondVertex) {
		return firstVertex;
	} else {
		return nil;
	}
}

-(BOOL)sameRibWith:(FFRib*)another {
	
	if ((self.firstVertex == another.firstVertex && self.secondVertex == another.secondVertex) || 
		(self.firstVertex == another.secondVertex && self.secondVertex == another.firstVertex)) {
		return YES;
	} else {
		return NO;
	}	
}

-(NSComparisonResult)compareWithRib:(FFRib*)anoher {
	
	if (self.length < anoher.length) {
		return NSOrderedAscending;
	} else if (self.length > anoher.length) {
		return NSOrderedDescending;
	} else {
		return NSOrderedSame;
	}
	
}

-(void)dealloc {

	[firstVertex release];
	[secondVertex release];
	[super dealloc];
	
}

@end

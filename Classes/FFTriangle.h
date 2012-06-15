//
//  Triangle.h
//  MathWars
//
//  Created by SwinX on 24.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MapObject.h"
#import "FFRib.h"


@interface FFTriangle : NSObject {

	MapObject* firstVertex;
	MapObject* secondVertex;
	MapObject* thirdVertex;
	
	FFRib* firstRib;
	FFRib* secondRib;
	FFRib* thirdRib;
	
}

@property(retain) MapObject* firstVertex;
@property(retain) MapObject* secondVertex;
@property(retain) MapObject* thirdVertex;
@property(retain) FFRib* firstRib;
@property(retain) FFRib* secondRib;
@property(retain) FFRib* thirdRib;

-(id)initWithFirstVertex:(MapObject*)_firstVertex andSecondVertex:(MapObject*)_secondVertex andThirdVertex:(MapObject*)_thirdVertex;
-(BOOL)vertexInside:(MapObject *)vertex;
-(void)linkMapObjects;
-(void)removeMapObjectFromVertexNeighbours:(MapObject*)mapObject;

@end

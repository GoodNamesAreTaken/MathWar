//
//  triangleRib.h
//  MathWars
//
//  Created by SwinX on 25.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MapObject.h"


@interface FFRib : NSObject {

	MapObject* firstVertex;
	MapObject* secondVertex;
	
	float length;
	
}

@property(readonly) float length;

@property(readonly) MapObject* firstVertex;
@property(readonly) MapObject* secondVertex;

+(id)ribBetween:(MapObject*)first and:(MapObject*)second;
+(float)getLengthBetweenFirstVerticies:(MapObject*)_firstVertex andSecondVertex:(MapObject*)_secondVertex;
-(id)initWithFirstVertex:(MapObject*)_firstVertex andSecondVertex:(MapObject*)_secondVertex;
-(void)linkMapObjects;
-(BOOL)sameRibWith:(FFRib*)another;

@end

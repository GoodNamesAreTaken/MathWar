//
//  LinePointer.h
//  MathWars
//
//  Created by SwinX on 06.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "MapObject.h"
#import "FFSprite.h"

@interface LinePointer : FFCompositeView {

	MapObject* start;
	MapObject* end;
	FFSprite* arrow;
	
	NSMutableArray* sprites;
	float length;
	
}

-(id)initWithStartObject:(MapObject*)startObject andEndObject:(MapObject*)endObject;

@end

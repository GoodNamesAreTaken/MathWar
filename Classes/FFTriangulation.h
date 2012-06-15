//
//  Triangulation.h
//  MathWars
//
//  Created by SwinX on 25.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MapObject.h"


@interface FFTriangulation : NSObject {
	
	NSMutableArray* initialObjects;
	NSMutableArray* triangles;
	
	MapObject* firstStarting;
	MapObject* secondStarting;
	MapObject* thirdStarting;
	MapObject* fourthStarting;

}

-(id)initWithMapObjects:(NSMutableArray*)mapObjects;
-(void)createNeighbourhood;

@end

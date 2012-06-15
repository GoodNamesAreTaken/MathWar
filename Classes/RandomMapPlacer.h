//
//  RandomMapCell.h
//  MathWars
//
//  Created by Inf on 24.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#define CELL_SIZE 146
#import "NetworkProtocol.h"

@interface RandomMapPlacer : NSObject {
	BOOL cells[7][7];
	MWNetWorkMapParams* mapTemplate;
}

-(id)initWithTemplate:(MWNetWorkMapParams*)params;
-(void)createMapWithObjectCount:(uint32_t)objectCount;
-(void)createRoads;
-(void)addBaseWithOwner:(int)owner;
-(void)addObject;

@end

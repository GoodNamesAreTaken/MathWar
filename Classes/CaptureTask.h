//
//  CaptureTask.h
//  MathWars
//
//  Created by Inf on 06.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "HighLevelTask.h"
#import "Building.h"

@interface CaptureTask : NSObject<HighLevelTask> {
	float basicCost;
	Building* target;
	id performer;
}

-(id)initWithTarget:(Building *)targetBuilding;

@end

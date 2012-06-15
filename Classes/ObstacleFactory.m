//
//  ObstacleFactory.m
//  MathWars
//
//  Created by SwinX on 11.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "ObstacleFactory.h"

#import "MineField.h"
#import "Swamp.h"
#import "Gorge.h"
#import "Barricades.h" 


@implementation ObstacleFactory

+(ObstacleFactory*)sharedFactory {
	
	static ObstacleFactory* factory = nil;
	
	@synchronized(self) {
		if (factory == nil) {
			factory = [[ObstacleFactory alloc] init];
		}
	}
	return factory;
}

-(Obstacle*)createObstacleOfType:(MWMapObjectType)type {
	
	switch (type) {
		case MWMapObjectMineField:
			return [[[MineField alloc] init] autorelease];
		break;
		case MWMapObjectSwamp:
			return [[[Swamp alloc] init] autorelease];
		break;
		case MWMapObjectGorge:
			return [[[Gorge alloc] init] autorelease];
		break;
		case MWMapObjectBarricades:
			return [[[Barricades alloc] init] autorelease];
		break;

		default:
			NSLog(@"Unknown obstacle type");
			return nil;
		break;
	}

}

@end

//
//  ObstacleFactory.h
//  MathWars
//
//  Created by SwinX on 11.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Obstacle.h"
#import "NetworkProtocol.h"

#define OBSTACLES_COUNT 4

@interface ObstacleFactory : NSObject {

}

+(ObstacleFactory*)sharedFactory;
-(Obstacle*)createObstacleOfType:(MWMapObjectType)type;

@end

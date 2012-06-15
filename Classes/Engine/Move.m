//
//  Move.m
//  MathWars
//
//  Created by Inf on 02.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Move.h"

#define PRECISION 0.0001f

@implementation Move

+(id) view:(FFView*)view to:(CGPoint)target withSpeed:(float)speed {
	return [[[Move alloc] initWithView:view targetPoint:target andSpeed:speed] autorelease];
}

-(id)initWithView:(FFView*)viewToMove targetPoint:(CGPoint)point andSpeed:(float)moveSpeed {
	if (self = [super init]) {
		view = viewToMove;
		target = point;
		speed = moveSpeed;
		
	}
	return self;
}

-(void)start {
	
	speedVector.x = target.x - view.x;
	speedVector.y = target.y - view.y;
	
	float length = sqrt(speedVector.x * speedVector.x + speedVector.y * speedVector.y);
	
	if (length > PRECISION) {
		speedVector.x /= length;
		speedVector.y /= length;
		
		speedVector.x *= speed;
		speedVector.y *= speed;
	}
	
}

-(void)doForTime:(CFTimeInterval)time {
	[view setPositionX:view.x + speedVector.x*time y:view.y + speedVector.y * time];
	if (self.finished) {
		[view setPositionX:target.x y:target.y];
	}
	
}

-(BOOL)finished {
	CGPoint targetVector;
	targetVector.x = target.x - view.x;
	targetVector.y = target.y - view.y;
	
	//вектор скорости и цели должен отличатся по направлению
	return targetVector.x * speedVector.x < PRECISION && targetVector.y * speedVector.y < PRECISION;
}

/*-(void)dealloc {
	[view release];
	[super dealloc];
}*/

@end

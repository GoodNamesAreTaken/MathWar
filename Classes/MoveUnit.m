//
//  MoveUnit.m
//  MathWars
//
//  Created by Inf on 25.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MoveUnit.h"
#import "GameUI.h"

@implementation Move(Unit)

+(id)unit:(MapUnitView*)unit to:(CGPoint)target withSpeed:(float)speed; {
	return [[[MoveUnit alloc] initWithView:unit targetPoint:target andSpeed:speed] autorelease];
}

@end

@implementation MoveUnit

-(void)doForTime:(CFTimeInterval)time {
	[super doForTime:time];
	[[GameUI sharedUI].mapView scrollToX:view.absoluteX y:view.absoluteY];
}

@end

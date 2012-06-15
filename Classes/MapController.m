//
//  MapController.m
//  MathWars
//
//  Created by Inf on 25.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MapController.h"
#import "GameUI.h"

@implementation MapController


+(id)controllerForView:(MapView*)view {
	return [[[MapController alloc] initWithView:view] autorelease];
}

-(id)initWithView:(MapView*)mapView {
	if (self = [super init]) {
		view = [mapView retain];
	}
	return self;
}

-(void)moveTouchFrom:(CGPoint)source to:(CGPoint)destination {
	
	if (![GameUI sharedUI].lock.isMapLocked) {
		float dx = destination.x - source.x;
		float dy = destination.y - source.y;
		
		[view shiftForX:dx y:dy];
        viewIsMoving = YES;
	}
}

-(void)endTouchAt:(CGPoint)point {
    if (viewIsMoving) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MapMoved" object:view];
        viewIsMoving = NO;
    }
	
}

-(void)dealloc {
	[view release];
	[super dealloc];
}

@end

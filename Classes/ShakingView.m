//
//  untitled.m
//  MathWars
//
//  Created by SwinX on 05.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "ShakingView.h"

@interface ShakingView(Private)

-(void)moveForward;
-(void)moveBackward;

@end

@implementation ShakingView

-(id)initWithDistance:(float)_distance {

	if (self = [super init]) {
		distance = _distance;
		stopped = YES;
		slideSpeed = 150.0f;
	}
	
	return self;
}

-(void)shakeOnX {
	stopped = NO;
	start = CGPointMake(self.x - distance, self.y);
	target = CGPointMake(self.x + distance, self.y);
	[self moveForward];
}

-(void)shakeOnY {
	stopped = NO;
	start = CGPointMake(self.x, self.y - distance);
	target = CGPointMake(self.x, self.y + distance);
	[self moveForward];
}

-(void)stop {
	stopped = YES;
}

-(void)moveForward {
	if (!stopped) {
		[self slideFrom:start To:target withAfterSlideAction:@selector(moveBackward) ofObject:self];
	}
}

-(void)moveBackward {
	if (!stopped) {
		[self slideFrom:target To:start withAfterSlideAction:@selector(moveForward) ofObject:self];
	}
}

@end

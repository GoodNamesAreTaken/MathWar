//
//  Trigger.m
//  MathWars
//
//  Created by Inf on 31.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Trigger.h"


@implementation Trigger
@synthesize finished;

+(id)event:(FFEvent*)eventToTrigger {
	return [[[Trigger alloc] initWithEvent:eventToTrigger] autorelease];
}

-(id)initWithEvent:(FFEvent*)event {
	if (self = [super init]) {
		eventToTrigger = [event retain];
	}
	return self;
}

-(void)start {
	finished = NO;
}

-(void)doForTime:(CFTimeInterval)time {
	[eventToTrigger triggerBy:self];
	finished = YES;
}

-(void)dealloc {
	[eventToTrigger release];
	[super dealloc];
}


@end

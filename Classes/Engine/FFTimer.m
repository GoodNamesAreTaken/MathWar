//
//  Timer.m
//  SimpleRPG
//
//  Created by SwinX on 18.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFTimer.h"
#import "FFGame.h"

@implementation FFTimer

@synthesize action;
@synthesize stopped;
@synthesize timeInterval;
@synthesize singleUse;

-(id)initWithInterval:(float)interval andSingleUse:(BOOL)single {

	if (self = [super init]) {
		
		action = [[FFEvent alloc] init];
		timeInterval = interval;
		currentTime = interval;
		singleUse = single;
		stopped = NO;
		
	}
	
	return self;
}

-(void)update:(float)timeDelta {
	currentTime -= timeDelta;
	if (currentTime < 0.0 && !stopped) {
		[action triggerBy:self];
		if (!singleUse) {
			currentTime = timeInterval;
		} else {
			[self stop];
		}
	}
}

-(NSString*)timeLeft {
	return [[FFGame sharedGame].timerManager stringFromTimeInterval:currentTime];
}

-(void)start {
	stopped = NO;
}

-(void)stop {
	stopped = YES;
}

-(void)dealloc {
	
	[action release];
	[super dealloc];
	
}

@end

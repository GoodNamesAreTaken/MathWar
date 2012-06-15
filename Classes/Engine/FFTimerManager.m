//
//  TimerManager.m
//  SimpleRPG
//
//  Created by SwinX on 18.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFTimerManager.h"


@implementation FFTimerManager

+(FFTimerManager*)timerManager {

	return [[[FFTimerManager alloc] init] autorelease];
	
}
-(id)init {
	
	if (self = [super init]) {
		timers = [[NSMutableArray alloc] init];
	}
	
	return self;
	
}

-(FFTimer*)getTimerWithInterval:(float)interval andSingleUse:(BOOL)singleUse {
	
	FFTimer* timer = [[FFTimer alloc] initWithInterval:interval andSingleUse:singleUse];
	[timers addObject:timer];
	return [timer autorelease];
		
}

-(void)removeTimer:(FFTimer*)timer {
	[timers removeObject:timer];
}

-(void)addTimer:(FFTimer*)timer {
	[timers addObject:timer];
}

-(void)updateTime:(CFTimeInterval)elapsed {
	NSArray* safeCopy = [timers copy];
	for (FFTimer* timer in safeCopy) {
		if (!timer.stopped) {
			[timer update:elapsed];
		} else {
			[timers removeObject:timer];
		}
	}
	[safeCopy release];
}

- (NSString*)stringFromTimeInterval:(NSTimeInterval)time {
	int seconds, minutes, hours;
	hours = time / 3600;
	time = time - (hours * 3600);
	minutes = time / 60;
	time = time - (minutes * 60);
	seconds = time;
	
	return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

-(void)removeAllTimers {
	[timers removeAllObjects];
}

-(void)dealloc {
	
	[timers release];
	[super dealloc];
	
}

@end

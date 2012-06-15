//
//  TimerManager.h
//  SimpleRPG
//
//  Created by SwinX on 18.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFTimer.h"


@interface FFTimerManager : NSObject {

	NSMutableArray* timers;
	
}

+(FFTimerManager*)timerManager;
-(NSString*)stringFromTimeInterval:(NSTimeInterval)time;
-(FFTimer*)getTimerWithInterval:(float)interval andSingleUse:(BOOL)singleUse;
-(void)updateTime:(CFTimeInterval)elapsed;
-(void)addTimer:(FFTimer*)timer;
-(void)removeTimer:(FFTimer*)timer;
-(void)removeAllTimers;

@end

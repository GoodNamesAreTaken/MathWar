//
//  Timer.h
//  SimpleRPG
//
//  Created by SwinX on 18.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFEvent.h"

@interface FFTimer : NSObject {

	float timeInterval;
	float currentTime;
	BOOL singleUse;
	BOOL stopped;
	FFEvent* action;
	
}

@property(readonly) FFEvent* action;
@property(readonly) BOOL stopped;
@property float timeInterval;
@property BOOL singleUse;

-(id)initWithInterval:(float)interval andSingleUse:(BOOL)single;
-(void)update:(float)timeDelta;
-(NSString*)timeLeft;
-(void)start;
-(void)stop;

@end

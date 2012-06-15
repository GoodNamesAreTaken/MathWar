//
//  Trigger.h
//  MathWars
//
//  Created by Inf on 31.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFAction.h"
#import "FFEvent.h"

@interface Trigger : NSObject<FFAction> {
	FFEvent* eventToTrigger;
	BOOL finished;
}

+(id)event:(FFEvent*)eventToTrigger;
-(id)initWithEvent:(FFEvent*)event;

@end

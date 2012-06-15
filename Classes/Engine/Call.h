//
//  Call.h
//  MathWars
//
//  Created by Inf on 09.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFAction.h"


@interface Call : NSObject<FFAction> {
	BOOL finished;
	SEL selector;
	id object;
	id parameter;
}

+(id)selector:(SEL)selector ofObject:(id)object;
+(id)selector:(SEL)selector ofObject:(id)object withParam:(id)param;

-(id)initWithObject:(id)targetObject andSelector:(SEL)targetSelector andParameter:(id)param;

@end

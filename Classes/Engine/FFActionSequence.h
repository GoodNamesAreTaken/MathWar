//
//  ActionSequence.h
//  MathWars
//
//  Created by Inf on 23.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFAction.h"


@interface FFActionSequence : NSObject<FFAction> {
	NSMutableArray* sequence;
}

-(id)initWithActions:(id<FFAction>)first, ...;

-(void)add:(id<FFAction>)action;

@end

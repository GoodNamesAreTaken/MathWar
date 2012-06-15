//
//  ActionManager.m
//  MathWars
//
//  Created by Inf on 23.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFActionManager.h"


@implementation FFActionManager
@synthesize delegate;

-(id)init {
	if (self = [super init]) {
		actions = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)addAction:(id<FFAction>) action {
	[actions addObject:action];
	[action start];
}

-(void)cancelAction:(id<FFAction>)action {
    [actions removeObject:action];
}

-(void)doActions:(CFTimeInterval)elapsedTime {
	NSArray* safeCopy = [actions copy];
	
	for (id<FFAction> action in safeCopy) {
		[action doForTime:elapsedTime];
		if (action.finished) {
			[actions removeObject:action];
		}
	}
	[safeCopy release];
	
	if (actions.count == 0) {
		[delegate allActionsFinished];
	}
}

-(void)removeAllActions {
	[actions removeAllObjects];
}

-(void)dealloc {
	[actions release];
	[super dealloc];
}

@end

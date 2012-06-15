//
//  ActionSequence.m
//  MathWars
//
//  Created by Inf on 23.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFActionSequence.h"


@implementation FFActionSequence

-(id)init {
	if (self = [super init]) {
		sequence = [[NSMutableArray alloc] init];
	}
	return self;
}

-(id)initWithActions:(id<FFAction>)first, ... {
	if (self = [super init]) {
		sequence = [[NSMutableArray alloc] init];
		
		va_list args;
		va_start(args, first);
		
		id<FFAction> action = first;
		while (action != nil) {
			[self add:action];
			action = va_arg(args, id<FFAction>);
		}
		va_end(args);
	}
	return self;
}

//Запуск первого действияв списке
-(void)start {
	if (!self.finished) {
		[[sequence objectAtIndex:0] start];
	}
}


/** */


-(void)add:(id<FFAction>)action {
	[sequence addObject:action];
}

-(void)doForTime:(CFTimeInterval)time {
	if (!self.finished) {
		[[sequence objectAtIndex:0] doForTime:time];
		
		if ([[sequence objectAtIndex:0] finished]) {
			[sequence removeObjectAtIndex:0];
			[self start];
		}
	}
}

-(BOOL)finished {
	return sequence.count == 0;
}

-(void)dealloc {
	[sequence release];
	[super dealloc];
}

@end

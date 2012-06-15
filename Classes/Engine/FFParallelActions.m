//
//  FFParallelActions.m
//  MathWars
//
//  Created by Inf on 31.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFParallelActions.h"


@implementation FFParallelActions
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
	for (id<FFAction> action in sequence) {
		[action start];
	}
}

-(void)add:(id<FFAction>)action {
	[sequence addObject:action];
}

-(void)doForTime:(CFTimeInterval)time {
	NSMutableArray* toDelete = [NSMutableArray array];
	
	for (id<FFAction> action in sequence) {
		[action doForTime:time];
		if (action.finished) {
			[toDelete addObject:action];
		}
	}
	[sequence removeObjectsInArray:toDelete];
	
}

-(BOOL)finished {
	return sequence.count == 0;
}

-(void)dealloc {
	[sequence release];
	[super dealloc];
}

@end

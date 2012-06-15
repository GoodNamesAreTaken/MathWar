//
//  Call.m
//  MathWars
//
//  Created by Inf on 09.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Call.h"


@implementation Call
@synthesize finished;

+(id)selector:(SEL)selector ofObject:(id)object {
	return [[[Call alloc] initWithObject:object andSelector:selector andParameter:nil] autorelease];
}

+(id)selector:(SEL)selector ofObject:(id)object withParam:(id)param {
	return [[[Call alloc] initWithObject:object andSelector:selector andParameter:param] autorelease];
}

-(id)initWithObject:(id)targetObject andSelector:(SEL)targetSelector andParameter:(id)param {
	if (self = [super init]) {
		object = [targetObject retain];
		selector = targetSelector;
		parameter = param;
	}
	return self;
}


-(void)start {
	finished = NO;
}

-(void)doForTime:(CFTimeInterval)time {
	[object performSelector:selector withObject:parameter];
	finished = YES;
}

-(void)dealloc {
	[object release];
	[super dealloc];
}

@end

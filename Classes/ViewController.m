//
//  ViewController.m
//  MathWars
//
//  Created by SwinX on 02.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

+(id)controllerWithView:(FFView*)_view {
	return [[[ViewController alloc] initWithView:_view] autorelease];
}

-(id)initWithView:(FFView*)_view {
	if (self = [super init]) {
		view = [_view retain];
	}	
	return self;
}

-(void)addedToGame {
	[view show];
}

-(void)removedFromGame {
	[view hide];
}

-(void)dealloc {
	[view release];
	[super dealloc];
}

@end

//
//  CompositeView.m
//  MathWars
//
//  Created by Inf on 22.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFCompositeView.h"


@implementation FFCompositeView

-(id)init {
	if (self = [super init]) {
		children = [[NSMutableArray alloc] init];
		showing = NO;
	}
	return self;
}

-(void)addChild:(FFView*)child {
	[children addObject:child];
	[child setParent:self];
	
	if (showing) {
		[child show];
	}
}

-(void)removeChild:(FFView*)child {
	[children removeObject:child];
	if (showing) {
		[child hide];
	}
	
}

-(BOOL)hasChild:(FFView*)child {
	return [children containsObject:child];
}

-(void)showIn:(FFGenericRenderer*)renderer {
	if (!showing) {
		showing = YES;
		for (FFView* child in children) {
			[child showIn:renderer];
		}
	}
	
}

-(void)hideIn:(FFGenericRenderer*)renderer {
	showing = NO;
	for (FFView* child in children) {
		[child hideIn:renderer];
	}
}

-(void)updateAbsolutePosition {
	[super updateAbsoluteX];
	[super updateAbsoluteY];
	
	for (FFView* child in children) {
		[child updateAbsolutePosition];
	}
}

-(void)updateAbsoluteX {
	[super updateAbsoluteX];
	for (FFView* child in children) {
		[child updateAbsoluteX];
	}
}

-(void)updateAbsoluteY {
	[super updateAbsoluteY];
	for (FFView* child in children) {
		[child updateAbsoluteY];
	}
}

-(void)updateAbsoluteLayer {
	for (FFView* child in children) {
		[child updateAbsoluteLayer];
	}
}

-(BOOL)pointInside:(CGPoint)point {
	for (FFView* child in children) {
		if ([child pointInside:point]) {
			return YES;
		}
	}
	return NO;
}

-(void)dealloc {
	
	[children release];
	[super dealloc];
}

@end

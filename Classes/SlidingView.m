//
//  DropDownView.m
//  MathWars
//
//  Created by SwinX on 23.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "SlidingView.h"
#import "Move.h"
#import "Call.h"
#import "FFActionSequence.h"
#import "FFGame.h"

#define DEFAULT_SLIDE_SPEED 400.0f

@implementation SlidingView

@synthesize slideSpeed;

-(id)init {
	if (self = [super init]) {
		slideSpeed = DEFAULT_SLIDE_SPEED;
	}
	return self;
}
 
-(void)slideFrom:(CGPoint)start To:(CGPoint)target withAfterSlideAction:(SEL)action ofObject:(id)object {

	self.x = start.x;
	self.y = start.y;
	
	[self show];
	
	
	
	[[FFGame sharedGame].actionManager addAction:[self slideActionFrom:start To:target withAfterSlideAction:action ofObject:object]];
	
}

-(id<FFAction>)slideActionFrom:(CGPoint)start To:(CGPoint)target withAfterSlideAction:(SEL)action ofObject:(id)object {
	Move* move = [Move view:self to:target withSpeed:slideSpeed];
	
	if (object) {
		Call* call = [Call selector:action ofObject:object];
		
		FFActionSequence* sequence = [[FFActionSequence alloc] initWithActions:move, call, nil];
		return [sequence autorelease];
	} else {
		return move;
	}
}

@end

//
//  Control.m
//  SimpleRPG
//
//  Created by Александр on 20.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFControl.h"
#import "FFGame.h"


@implementation FFControl

@synthesize dragable, disabled;

-(id)init {
	
	if (self = [super init]) {
		
		dragable = NO;
		disabled = NO;
		callClickOnEnd = NO;
		
	}
	
	return self;
}

-(void)clickBegan {
	
//для переопределения потомками
	
}

-(void)clickEnded {
	
//для переопределения потомками
	
}

-(void)draggedForX:(float)_x Y:(float)_y {
	
//для переопределения потомками	
	
}

-(void)resetControlState {
	
	//Для переопределения потомками
	
}

-(void)showIn:(FFGenericRenderer*)renderer {
	[super showIn:renderer];
	[[FFGame sharedGame] addController:self];
}

-(void)hideIn:(FFGenericRenderer*)renderer {
	[super hideIn:renderer];
	[[FFGame sharedGame] removeController:self];
}

-(void)beginTouchAt:(CGPoint)point {

	if ([self pointInside:point] && !disabled) {
		callClickOnEnd = YES;
		[self clickBegan];

	} else {
		callClickOnEnd = NO;
	}

	
}

-(void)endTouchAt:(CGPoint)point {
	
	if ([self pointInside:point] && !disabled && callClickOnEnd) {
		
		[self clickEnded];
		
	} else {
		
		[self resetControlState];
		
	}
	
}

-(void)moveTouchFrom:(CGPoint)source to:(CGPoint)destination {
	if ([self pointInside:source] && !disabled) {
		
		if (dragable) {
			
			self.x = destination.x;
			self.y = destination.y;
			
		} else {
			float _x = destination.x - source.x;
			float _y = destination.y - source.y;
			[self draggedForX:_x Y:_y];
			
		}

	}
}

@end

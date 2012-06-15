//
//  View.m
//  MathWars
//
//  Created by Inf on 22.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFGame.h"
#import "FFView.h"


@implementation FFView
@synthesize x, y, layer, parent, absoluteX, absoluteY;

-(void)setX:(float)newX {
	x = newX;
	[self updateAbsoluteX];
}

-(void)setY:(float)newY {
	y = newY;
	[self updateAbsoluteY];
}

-(void)setPositionX:(float)newX y:(float)newY {
	x = newX;
	y= newY;
	[self updateAbsolutePosition];
}

-(void)setLayer:(uint32_t)newLayer {
	layer = newLayer;
	[self updateAbsoluteLayer];
}

/*-(float)absoluteX {
	if (parent == nil) {
		return x;
	}
	return parent.absoluteX + x;
}

-(float)absoluteY {
	if (parent == nil) {
		return y;
	}
	return parent.absoluteY + y;
}*/

-(void)setAbsoluteX:(float)absoluteX {
	[self doesNotRecognizeSelector:_cmd];
}

-(void)setAbsoluteY:(float)absoluteY {
	[self doesNotRecognizeSelector:_cmd];
}


-(uint32_t)absoluteLayer {
	if (parent == nil) {
		return layer;
	}
	return parent.absoluteLayer + layer;
}

-(void)updateAbsoluteX {
	if (parent == nil) {
		absoluteX = x;
	} else {
		absoluteX = parent.absoluteX + x;
	}
}

-(void)updateAbsoluteY {

	if (parent == nil) {
		absoluteY = y;
	} else {
		absoluteY = parent.absoluteY + y;
	}
}

-(void)updateAbsolutePosition {
	[self updateAbsoluteX];
	[self updateAbsoluteY];
}

-(void)updateAbsoluteLayer {
	[self doesNotRecognizeSelector:_cmd];
}


-(void)show {
	[self showIn:[FFGame sharedGame].renderer];
}

-(void)hide {
	[self hideIn:[FFGame sharedGame].renderer];
}

-(void)showIn:(FFGenericRenderer*)renderer {
	[self doesNotRecognizeSelector:_cmd];
}

-(void)hideIn:(FFGenericRenderer*)renderer {
	[self doesNotRecognizeSelector:_cmd];
}

-(BOOL)pointInside:(CGPoint)point {
	return NO;
}

-(float)width {
	return 0.0f;
}

-(float)height {
	return 0.0f;
}

-(void)setParent:(FFView *)newParent {
	if (parent != newParent) {
		parent = newParent;
		
		[self updateAbsolutePosition];
		[self updateAbsoluteLayer];
	}
}

-(void)dealloc {
	[super dealloc];
}

@end

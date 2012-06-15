//
//  View.h
//  MathWars
//
//  Created by Inf on 22.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "FFGenericRenderer.h"


@interface FFView : NSObject {
	float x;
	float y;
	uint32_t layer;
	
	FFView* parent;
	
	float absoluteX;
	float absoluteY;
}

@property(nonatomic) float x;
@property(nonatomic) float y;
@property(nonatomic) uint32_t layer;
@property(nonatomic, assign) FFView* parent;

@property(nonatomic) float absoluteX;
@property(nonatomic) float absoluteY;
@property(nonatomic, readonly) uint32_t absoluteLayer;
@property(nonatomic, readonly) float width;
@property(nonatomic, readonly) float height;

-(void)show;
-(void)hide;

-(void)showIn:(FFGenericRenderer*)renderer;
-(void)hideIn:(FFGenericRenderer*)renderer;

-(void)updateAbsoluteX;
-(void)updateAbsoluteY;
-(void)updateAbsolutePosition;
-(void)updateAbsoluteLayer;

-(BOOL)pointInside:(CGPoint)point;

-(void)setPositionX:(float)newX y:(float)newY;

@end

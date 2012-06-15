//
//  ShakingView.h
//  MathWars
//
//  Created by SwinX on 05.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "SlidingView.h"


@interface ShakingView : SlidingView {
	float distance;
	BOOL stopped;
	
	CGPoint start;
	CGPoint target;
}

-(id)initWithDistance:(float)_distance;
-(void)shakeOnX;
-(void)shakeOnY;
-(void)stop;

@end

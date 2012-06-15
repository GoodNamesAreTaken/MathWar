//
//  DropDownView.h
//  MathWars
//
//  Created by SwinX on 23.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFAction.h"

@interface SlidingView : FFCompositeView {
	float slideSpeed;
}

@property float slideSpeed;

-(void)slideFrom:(CGPoint)start To:(CGPoint)target withAfterSlideAction:(SEL)action ofObject:(id)object;
-(id<FFAction>)slideActionFrom:(CGPoint)start To:(CGPoint)target withAfterSlideAction:(SEL)action ofObject:(id)object;

@end

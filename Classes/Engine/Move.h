//
//  Move.h
//  MathWars
//
//  Created by Inf on 02.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFAction.h"
#import "FFView.h"


@interface Move : NSObject<FFAction> {
	FFView* view;
	
	float speed;
	CGPoint speedVector;	
	CGPoint target;
}

+(id) view:(FFView*)view to:(CGPoint)target withSpeed:(float)speed;

-(id)initWithView:(FFView*)viewToMove targetPoint:(CGPoint)point andSpeed:(float)moveSpeed;

@end

//
//  Control.h
//  SimpleRPG
//
//  Created by Александр on 20.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFController.h"


@interface FFControl : FFCompositeView<FFController> {

	BOOL dragable;
	BOOL disabled;
	BOOL callClickOnEnd;
	
}

@property BOOL dragable;
@property BOOL disabled;

-(void)clickBegan;
-(void)clickEnded;
-(void)draggedForX:(float)_x Y:(float)_y;
-(void)resetControlState;


@end
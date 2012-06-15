//
//  ViewController.h
//  MathWars
//
//  Created by SwinX on 02.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFController.h"
#import "FFView.h"

@interface ViewController : NSObject<FFController> {
	FFView* view;
}

+(id)controllerWithView:(FFView*)_view;
-(id)initWithView:(FFView*)_view;

@end

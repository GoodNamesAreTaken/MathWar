//
//  MapController.h
//  MathWars
//
//  Created by Inf on 25.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFController.h"
#import "MapView.h"

@interface MapController : NSObject<FFController> {
	MapView* view;
    BOOL viewIsMoving;
}

+(id)controllerForView:(MapView*)view;
-(id)initWithView:(MapView*)view;

@end

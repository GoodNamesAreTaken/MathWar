//
//  FingerView.h
//  MathWars
//
//  Created by Inf on 10.08.10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFButton.h"
#import "MapObject.h"
#import "Move.h"


@interface FingerView : FFCompositeView {
    MapObject* focusObject;
    Move* moveAction;
}

@property(retain) Move* moveAction;

-(void)focusOnView:(FFView*)view;
-(void)focusOnMapObject:(MapObject*)mapObject;
-(void)focusOnNearestUnitTo:(uint8_t)objectId;
-(void)focusOnMapObjectById:(uint8_t)objectId;

@end

//
//  StartMenuController.h
//  MathWars
//
//  Created by Inf on 10.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFController.h"
#import "StartMenuView.h"


@interface StartMenuController : NSObject<FFController> {
	StartMenuView* view;
}

+(id) controller;
-(void)tryStartCampaign;
-(void)tryStartSingleGame; 
-(void) multiplayer;
-(void) tutorial;

@end

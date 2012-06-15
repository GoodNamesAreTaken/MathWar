//
//  CampaignController.h
//  MathWars
//
//  Created by SwinX on 19.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFController.h"
#import "CampaignView.h"
#import "Campaign.h"


@interface CampaignController : NSObject<FFController> {
	Campaign* model;
	CampaignView* view;
}

-(id)init;
+(CampaignController*)controller;

@end

//
//  CampaignAIRestrictions.m
//  MathWars
//
//  Created by SwinX on 12.08.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "CampaignAIRestrictions.h"
#import "UnitHelper.h"


@implementation CampaignAIRestrictions

+(CampaignAIRestrictions*)restrictionsWithCampaign:(Campaign *)_campaign {
	return [[[CampaignAIRestrictions alloc] initWithCampaign:_campaign] autorelease];
}

-(BOOL)isUnitAvaliable:(uint8_t)unitType {
	return turnsPassed >= [[UnitHelper sharedHelper] getTurnsBefore:unitType] && 
	campaign.missionsOpened >= [[UnitHelper sharedHelper] getMinimumLevelForUnit:unitType withLevel:0] - 1;
}

-(BOOL)isUpgrade:(uint8_t)upgradeLevel avaliableToUnit:(uint8_t)unitType {
	return campaign.missionsOpened >= [[UnitHelper sharedHelper] getMinimumLevelForUnit:unitType withLevel:upgradeLevel] - 1;
}

@end

//
//  CampaignRestrictions.m
//  MathWars
//
//  Created by Inf on 14.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "CampaignRestrictions.h"
#import "UnitHelper.h"


@implementation CampaignRestrictions

+(id)restrictionsWithCampaign:(Campaign*)_campaign {
	return [[[CampaignRestrictions alloc] initWithCampaign:_campaign] autorelease];
}

-(id)initWithCampaign:(Campaign*)_campaign {
	if (self = [super init]) {
		campaign = [_campaign retain];
		turnsPassed = 0;
	}
	return self;
}

-(BOOL)isUnitAvaliable:(uint8_t)unitType {
	return turnsPassed >= [[UnitHelper sharedHelper] getTurnsBefore:unitType] && 
			campaign.missionsOpened >= [[UnitHelper sharedHelper] getMinimumLevelForUnit:unitType withLevel:0];
}

-(BOOL)isUpgrade:(uint8_t)upgradeLevel avaliableToUnit:(uint8_t)unitType {
	return campaign.missionsOpened >= [[UnitHelper sharedHelper] getMinimumLevelForUnit:unitType withLevel:upgradeLevel];
}

-(void)nextTurn {
	turnsPassed++;
}

-(void)dealloc {
	[campaign release];
	[super dealloc];
}

@end

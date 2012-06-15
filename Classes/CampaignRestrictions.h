//
//  CampaignRestrictions.h
//  MathWars
//
//  Created by Inf on 14.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "Campaign.h"
#import "UnitRestrictions.h"


@interface CampaignRestrictions : NSObject<UnitRestrictions> {
	Campaign* campaign;
	uint16_t turnsPassed;
}

+(id)restrictionsWithCampaign:(Campaign*)_campaign;
-(id)initWithCampaign:(Campaign*)_campaign;

@end

//
//  TutorialResrictions.m
//  MathWars
//
//  Created by Inf on 28.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "TutorialResrictions.h"
#import "Unit.h"


@implementation TutorialResrictions

+(id)restrictions {
	return [[[TutorialResrictions alloc] init] autorelease];
}

-(BOOL)isUnitAvaliable:(uint8_t)unitType {
	return unitType == MWUnitTank;
}

-(BOOL)isUpgrade:(uint8_t)upgradeLevel avaliableToUnit:(uint8_t)unitType {
	return unitType == MWUnitTank && upgradeLevel == 1;
}

@end

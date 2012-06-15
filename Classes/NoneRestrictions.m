//
//  NoneRestrictins.m
//  MathWars
//
//  Created by Inf on 11.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "NoneRestrictions.h"


@implementation NoneRestrictions

+(id)restrictions {
	return [[[NoneRestrictions alloc] init] autorelease];
}

-(BOOL)isUnitAvaliable:(uint8_t)unitType {
	return YES;
}

-(BOOL)isUpgrade:(uint8_t)upgradeLevel avaliableToUnit:(uint8_t)unitType {
	return YES;
}

@end

//
//  UnitRestrictions.h
//  MathWars
//
//  Created by Inf on 11.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//


@protocol UnitRestrictions<NSObject>

-(BOOL)isUnitAvaliable:(uint8_t)unitType;
-(BOOL)isUpgrade:(uint8_t)upgradeLevel avaliableToUnit:(uint8_t)unitType;

@optional

-(void)nextTurn;

@end

//
//  Barricades.m
//  MathWars
//
//  Created by SwinX on 20.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Barricades.h"
#import "Player.h"


@implementation Barricades


-(void)negativeEffectOn:(Unit *)unit {
	[unit.owner showNotification:@"Go back!"];
	[unit moveTo:unit.previousLocation];
}

@end

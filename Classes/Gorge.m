//
//  Gorge.m
//  MathWars
//
//  Created by SwinX on 11.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Gorge.h"
#import "Player.h"


@implementation Gorge

-(id)init {
	return [self initWithPuzzleDifficulty:NORMAL_DIFFICULTY];
}

-(void)negativeEffectOn:(Unit *)unit {
	[unit.owner showNotification:@"Unit died"];
	[unit die];
}

@end

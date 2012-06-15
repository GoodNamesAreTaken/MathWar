//
//  Swamp.m
//  MathWars
//
//  Created by SwinX on 11.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Swamp.h"
#import "Player.h"

@implementation Swamp

-(id)init {
	return [self initWithPuzzleDifficulty:HARD_DIFFICULTY];
}

-(void)negativeEffectOn:(Unit *)unit {
	unit.attack--;
	if (unit.attack <= 0) {
		[unit.owner showNotification:@"Unit died"];
		[unit die];
	} else {
		[unit.owner showNotification:@"-1 attack"];
		[unit becomeGuardianOf:self];
	}

}

@end

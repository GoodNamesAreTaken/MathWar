//
//  MineField.m
//  MathWars
//
//  Created by SwinX on 09.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MineField.h"
#import "Puzzle.h"
#import "Player.h"


@implementation MineField

-(id)init {
	return [self initWithPuzzleDifficulty:NORMAL_DIFFICULTY];
}


-(void)negativeEffectOn:(Unit *)unit {
	unit.health -= 2;
	if (unit.isDead) {
		[unit.owner showNotification:@"Robot died"];
	} else {
		[unit.owner showNotification:@"-2 health"];
		[unit becomeGuardianOf:self];
	}

}

-(void)dealloc {
	[super dealloc];
}

@end

//
//  CombatDecision.m
//  MathWars
//
//  Created by SwinX on 02.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "CombatDecision.h"


@implementation CombatDecision

+(CombatDecision*)decisionOfPlayer:(AIPlayer*)player {
	return [[[CombatDecision alloc] initWithPlayer:player] autorelease];
}

-(void)performDecision {
	[decisive newDecision];
}

@end

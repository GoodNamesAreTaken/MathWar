//
//  CombatUnitSound.h
//  MathWars
//
//  Created by SwinX on 01.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFSound.h"
#import "Combat.h"
#import "Unit.h"


@interface CombatUnitSound : NSObject<CombatObserver> {
	NSString* attackerStrike;
	NSString* protectorStrike;
}

-(id)initWithAttacker:(MWUnitType)attacker andProtector:(MWUnitType)protector;


@end

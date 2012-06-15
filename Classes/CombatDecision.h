//
//  CombatDecision.h
//  MathWars
//
//  Created by SwinX on 02.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Decision.h"


@interface CombatDecision : Decision {

}

+(CombatDecision*)decisionOfPlayer:(AIPlayer*)player;
-(void)performDecision;

@end

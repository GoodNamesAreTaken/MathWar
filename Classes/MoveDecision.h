//
//  MoveDecision.h
//  MathWars
//
//  Created by SwinX on 01.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Decision.h"
#import "Unit.h"


@interface MoveDecision : Decision<UnitObserver> {
	
	Unit* unitToMove;
	MapObject* locationToGo;
	
}

+(MoveDecision*)move:(Unit*)unit toLocaion:(MapObject*)location;
-(id)initWithUnit:(Unit*)unit andLocation:(MapObject*)location;

@end

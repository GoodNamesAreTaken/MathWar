//
//  MoveUnit.h
//  MathWars
//
//  Created by Inf on 25.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Move.h"
#import "MapUnitView.h"

@interface Move(Unit)
+(id)unit:(MapUnitView*)unit to:(CGPoint)target withSpeed:(float)speed;
@end


@interface MoveUnit : Move {
	
}

@end

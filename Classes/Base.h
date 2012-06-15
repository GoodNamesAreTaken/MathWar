//
//  Base.h
//  MathWars
//
//  Created by SwinX on 30.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Factory.h"
#import "Unit.h"

@interface Base : Factory {
	
	Unit* baseGuardian;

}

@property(readonly) Unit* baseGuardian;

@end

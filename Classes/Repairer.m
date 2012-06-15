//
//  Repairer.m
//  MathWars
//
//  Created by Inf on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Repairer.h"

@implementation Repairer

-(void)onOwnerChange:(Player *)newOwner {
	[owner showNotification:@"Robots will not be repaired"];
	[owner removeObserver:self];
	[newOwner addObserver:self];
	[newOwner showNotification:@"Robots will be repaired each turn"];
}

-(void)playerStartedTurn:(Player *)player {
	for (Unit* unit in player.units) {
		if (unit.health < unit.maxHealth) {
			unit.health++;
		}
	}
}

@end

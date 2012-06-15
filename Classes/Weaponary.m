//
//  Weaponary.m
//  MathWars
//
//  Created by SwinX on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Weaponary.h"
#import "Unit.h"


@implementation Weaponary

-(void)onOwnerChange:(Player *)newOwner {
	
	for (Unit* unit in owner.units) {
		unit.attack--;
	}
	
	for (Unit* unit in newOwner.units) {
		unit.attack++;
	}
	
	[owner removeObserver:self];
	[owner showNotification:@"-1 attack to all robots"];
	
	[newOwner addObserver:self];
	[newOwner showNotification:@"+1 attack to all robots"];
	
}

-(void)player:(Player*)player assignedUnit:(Unit*)unit {
	unit.attack++;
}

@end

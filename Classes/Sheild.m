//
//  Sheild.m
//  MathWars
//
//  Created by Inf on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Sheild.h"


@implementation Sheild

-(void)onOwnerChange:(Player *)newOwner {
	[owner showNotification:@"-1 health to all robots"];
	[owner removeObserver:self];
	
	//уменьшим жизнь юнитов старого владельца на 1
	for (Unit* unit in owner.units) {
		unit.maxHealth--;
		
		if (unit.health > unit.maxHealth) {
			unit.health = unit.maxHealth;
		}
	}
	
	[newOwner addObserver:self];
	[newOwner showNotification:@"+1 health to all robots"];
	
	//увеличим жизнь юнитов нового владельца на 1
	for (Unit* unit in newOwner.units) {
		if (unit.health == unit.maxHealth) {
			unit.health++;
		}
		unit.maxHealth++;
	}
	
	//напишем еще один хороший комментарий
	
	//это коомментарий
}

-(void)player:(Player *)player assignedUnit:(Unit *)unit {
	unit.maxHealth++;
	unit.health++;
}

@end

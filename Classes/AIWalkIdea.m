//
//  AIWalkIdea.m
//  MathWars
//
//  Created by Inf on 04.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "AIWalkIdea.h"
#import "CoalWarehouse.h"

#import "Base.h"
#import "Factory.h"
#import "Weaponary.h"
#import "Repairer.h"

@implementation AIWalkIdea
@synthesize possible;
@synthesize unit;
@synthesize target;

+(id)walkIdeaForUnit:(Unit*)unit andTarget:(MapObject*)target {
	return [[[AIWalkIdea alloc] initWithUnit:unit andTarget:target] autorelease];
}

-(id)initWithUnit:(Unit*)walker andTarget:(MapObject*)targetObject {
	if (self = [super init]) {
		unit = [walker retain];
		target = [targetObject retain];
		possible = targetObject.guardian == nil || targetObject.guardian.owner != walker.owner;
	}
	return self;
}

-(float)costForEnemyBuilding:(Building*)enemyBuilding {
	if ([enemyBuilding isKindOfClass:[Base class]]) {
		Unit* baseGuardian = ((Base*)enemyBuilding).baseGuardian;
		int turnsToWin = baseGuardian.health / unit.attack;
		int turnsToLose = unit.health / baseGuardian.attack;
		return ((float)turnsToWin) / (turnsToWin + turnsToLose);
	} else if ([enemyBuilding isKindOfClass:[Factory class]]) {
		return 1.0f;
	} else if ([enemyBuilding isKindOfClass:[Weaponary class]]) {
		return 2.0f;
	}else if ([enemyBuilding isKindOfClass:[CoalWarehouse class]]) {
		return 2.0f;
	} else if ([enemyBuilding isKindOfClass:[CoalWarehouse class]]) {
		return 4.0f;
	} else if ([enemyBuilding isKindOfClass:[Repairer class]]) {
		return 4.0f;
	}
	return 0.0f;
}

-(float)chanceForUnit:(Unit*)attacker toDefeat:(Unit*)protector {
	int roundsToWin = protector.health / attacker.attack;
	int roundsToLose = attacker.health / protector.attack;
	
	return ((float)roundsToWin) / (roundsToWin + roundsToLose);
}

-(float)costForOurBase:(Base*)base {
	float cost = 0.0f;
	for (MapObject* neighbour in base.neighbours) {
		if (neighbour.guardian != nil && neighbour.guardian.owner != unit.owner) {
			float newCost = [self chanceForUnit:neighbour.guardian toDefeat:base.baseGuardian];
			
			if (newCost > cost) {
				cost = newCost;
			}
		}
	}
	return cost;
}

-(float)costForOurBuilding:(Building*)ourBuilding {
	if ([ourBuilding isKindOfClass:[Base class]]) {
		return [self costForOurBase:(Base*)ourBuilding];
	}
	for (MapObject* object in ourBuilding.neighbours) {
		if (object.guardian!= nil && object.guardian.owner != unit.owner) {
			return [self costForEnemyBuilding:ourBuilding];
		}
	}
	return 0.0f;
}

-(float)costForBuilding:(Building*)building {
	if (building.owner == unit.owner) {
		return [self costForOurBuilding:building];
	} else if (building.owner != nil) {
		return [self costForEnemyBuilding:building];
	} else {
		return [self costForEnemyBuilding:building] * 0.9f;
	}


}

-(float)costForObject:(MapObject*)object {
	NSMutableArray* openList = [NSMutableArray arrayWithObject:object];
	NSMutableArray* closedList = [NSMutableArray arrayWithArray:unit.location.neighbours];
	NSMutableArray* modifiersList = [NSMutableArray arrayWithObject:[NSNumber numberWithFloat:1.0f]];
	float cost = 0.0f;
	
	while ([openList count] > 0) {
		float objectCost = 0.0f;
		
		MapObject* currentObject = [openList objectAtIndex:0];
		float modifier = [[modifiersList objectAtIndex:0] floatValue];
		
		[openList removeObjectAtIndex:0];
		[modifiersList removeObjectAtIndex:0];
		[closedList addObject:currentObject];
		
		if ([currentObject isKindOfClass:[Building class]]) {
			objectCost += [self costForBuilding:(Building*)currentObject];
		}
		
		if (currentObject.guardian != nil && currentObject.guardian.owner != unit.owner) {
			objectCost *= [self chanceForUnit:unit toDefeat:currentObject.guardian];
		}
		
		cost += objectCost * modifier;
		
		if ([currentObject isKindOfClass:[Base class]] && ((Base*)currentObject).owner != unit.owner) {
			continue; //не учитываем соседей вражеской базы
		}
		
		for (MapObject* neighbour in object.neighbours) {
			if (![closedList containsObject:neighbour] && ![openList containsObject:neighbour]) {
				[openList addObject:neighbour];
				[modifiersList addObject:[NSNumber numberWithFloat:modifier * 0.5f]];
			}
		}
		
		
	}
	
	return cost;
}

-(float)cost {
	return [self costForObject:target];
}

-(void)make {
	[unit moveTo:target];
}

-(void)dealloc {
	[unit release];
	[target release];
	[super dealloc];
}

@end

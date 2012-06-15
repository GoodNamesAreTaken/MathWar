//
//  Unit.m
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "MapObject.h"
#import "Unit.h"
#import "Player.h"


@implementation Unit
@synthesize type, health, maxHealth, attack, owner, location, upgrades, previousLocation, isDead;
@synthesize unitID;


-(id)initWithType:(uint8_t)unitType {
	if (self = [super init]) {
		type = unitType;
		isDead = NO;
		upgrades = 0;
		observers = [[NSMutableArray alloc] init];
	}
	return self;
}

-(Unit*)copyWithNewOwner:(Player*)copyOwner {
	Unit* copy = [[Unit alloc] initWithType:type];
	copy.attack = self.attack;
	copy.health = self.health;
	copy.maxHealth = self.maxHealth;
	copy.owner = copyOwner;
	return [copy autorelease];
}

-(void)setOwner:(Player*)newOwner {
	owner = newOwner;
	
	[owner assignUnit:self];
}

-(void)moveTo:(MapObject*)newLocation {

	if (location != newLocation) {
		[self.location setGuardian:nil];
		
		for (id<UnitObserver> observer in observers) {
			[observer unit:self startedMovingTo:(MapObject*)newLocation withFinishAction:@selector(moveFinishedTo:)];
		}
		
	}
}

-(void)tryToMoveTo:(MapObject*)newLocation {
	if (owner.moveCount > 0) {
		owner.moveCount--;
		[self moveTo:newLocation];
	} else {
		[owner showNotification:@"No more moves this turn"];
	}
}

-(void)moveFinishedTo:(MapObject*)newLocation {
	
	previousLocation = self.location;
	location = newLocation;
	[location onUnitEnter:self];
	
	for (id<UnitObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(unit:finishedMovingTo:)]) {
			[observer  unit:self finishedMovingTo:newLocation];
		}
	}
}

-(void)addObserver:(id<UnitObserver>) observer {
	[observers addObject:observer];
}

-(void)removeObserver:(id<UnitObserver>) observer {
	[observers removeObject:observer];	
}

-(void)setMaxHealth:(int8_t)newHealth {
	maxHealth = newHealth;
//	health = maxHealth;
}

-(void)setHealth:(int8_t)newHealth {
	health = newHealth;
	if (health <= 0) {
		
		NSLog(@"Unit died");
		if (self == self.location.guardian) {
			self.location.guardian = nil;
		}
		isDead = YES;
		[owner unassignUnit:self];
		
		for (id<UnitObserver> observer in observers) {
			if ([observer respondsToSelector:@selector(unitDied)]) {
				[observer unitDied];
			}
		}
		[observers removeAllObjects];
	}
}

-(void)select {
	for (id<UnitObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(unitWasSelected:)]) {
			[observer unitWasSelected:self];
		}
	}	
}

-(void)cancelSelection {
	for (id<UnitObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(unitSelectionWasRemoved:)]) {
			[observer unitSelectionWasRemoved:self];
		}
	}
}

-(void)unitUpgraded {
	for (id<UnitObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(unitUpgraded:)]) {
			[observer unitUpgraded:self];
		}
	}	
}

-(void)die {
	self.health -= self.maxHealth;
}

-(BOOL)canBeUpgraded {
	return upgrades < MAXIMUM_UPGRADES && [owner.restrictions isUpgrade:upgrades+1 avaliableToUnit:type];
}

-(void)becomeGuardianOf:(MapObject *)object {
	location = object;
	
	for (id<UnitObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(unit:hasBecomeGuardianOf:)]) {
			[observer unit:self hasBecomeGuardianOf:object];
		}
	}
	
	object.guardian = self;
}

-(void)dealloc {
	[observers release];
	[super dealloc];
}

-(void)release {
	[super release];
}

-(id)retain {
	return [super retain];
}
 
@end

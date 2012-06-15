//
//  MapObject.m
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Combat.h"
#import "MapObject.h"
#import "MapObjectsInfo.h"

@implementation MapObject
@synthesize neighbours, guardian;
@synthesize x, y, objectId;

-(id)init {
	if (self = [super init]) {
		self.neighbours = [NSMutableArray array];
	}
	return self;
}

-(void)onUnitEnter:(Unit *)unit {
	if (guardian == nil) {
		[self unitEnteredEmptyCell:unit];
	} else if (self.guardian.owner != unit.owner) {
		[Combat startCombatBetweenAttacker:unit andProtector:self.guardian andDelegate:self];
	}
}

-(void)unitEnteredEmptyCell:(Unit*)unit {
	 [unit becomeGuardianOf:self];
}

-(void)protectorsBeatenBy:(Unit *)attacker {
	[attacker becomeGuardianOf:self];
}

-(BOOL)isNeutral {
	return guardian == nil;	
}

-(id)copyWithZone:(NSZone*)zone {
	MapObject* copy = [[[self class] allocWithZone:zone] init];
	copy.objectId = self.objectId;
	return copy;
}

-(BOOL)isEqual:(id)object {
	if (![object isKindOfClass:[MapObject class]]) {
		return NO;
	}
	return self.objectId == ((MapObject*)object).objectId;
}

-(void)cleanAllRoads {
	[self.neighbours removeAllObjects];
}

-(NSUInteger)hash {
	return objectId;
}

-(BOOL)belongsTo:(Player*)player {
	return guardian.owner == player;
}

-(void)setGuardian:(Unit *)newGuardian {
	if (guardian != newGuardian) {
		[guardian release];
		guardian = [newGuardian retain];
	}
	[[MapObjectsInfo info] showInfoAboutObject:self];
}

-(void)dealloc {
	self.neighbours = nil;
	self.guardian = nil;
	[super dealloc];
}

@end

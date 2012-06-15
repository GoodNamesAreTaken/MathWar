//
//  MoveDecision.m
//  MathWars
//
//  Created by SwinX on 01.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MoveDecision.h"
#import "MapObject.h"
#import "CombatDecision.h"
#import "Obstacle.h"
#import "Building.h"
#import "Base.h"


@implementation MoveDecision

+(MoveDecision*)move:(Unit*)unit toLocaion:(MapObject*)location {
	return [[[MoveDecision alloc] initWithUnit:unit andLocation:location] autorelease];
}

-(id)initWithUnit:(Unit*)unit andLocation:(MapObject*)location {

	if (self =[super initWithPlayer:nil]) {
		unitToMove = [unit retain];
		locationToGo = [location retain];
	}
	
	return self;
	
}

-(BOOL)possible {
	return locationToGo.guardian == nil || locationToGo.guardian.owner != unitToMove.owner;
}

-(void)performDecision {
	[unitToMove addObserver:self];
	[unitToMove tryToMoveTo:locationToGo];
}

-(void)unit:(Unit*)_unit startedMovingTo:(MapObject*)location withFinishAction:(SEL)action {
}

-(void)unit:(Unit *)_unit finishedMovingTo:(MapObject *)location {

	if (![location belongsTo:decisive] && (location.guardian != nil || [location isKindOfClass:[Base class]])) {
		decisive.decision = [CombatDecision decisionOfPlayer:decisive] ;
		[unitToMove removeObserver:self];
	}
}

-(void)unit:(Unit *)unit hasBecomeGuardianOf:(MapObject *)object {
	[unitToMove removeObserver:self];
	[decisive newDecision];
}

-(void)unitDied {
	[unitToMove removeObserver:self];
	[decisive newDecision];
}

-(void)dealloc {
	[unitToMove release];
	[locationToGo release];
	[super dealloc];
}

@end

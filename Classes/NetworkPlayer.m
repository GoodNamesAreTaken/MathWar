//
//  NetworkPlayer.m
//  MathWars
//
//  Created by Inf on 11.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "Factory.h"
#import "Unit.h"
#import "NetworkPlayer.h"
#import "NetworkPuzzle.h"
#import "MapLoader.h"
#import "NoneRestrictions.h"

@implementation NetworkPlayer

-(id)initWithConnection:(GameKitConnection*) gameConnection {
	if (self = [super init]) {
		connection = [gameConnection retain];
		connection.messageDelegate = self;
		factories = [[NSMutableDictionary alloc] init];
		self.restrictions = [NoneRestrictions restrictions]; 
	}
	return self;
}

-(void)destroyCurrentPuzzle {
	[currentPuzzle release];
	currentPuzzle = nil;
}

-(void)startTurn {
	[super startTurn];
}


-(Puzzle*)createPuzzleOfDifficulty:(uint32_t)difficulty withDelegate:(id<PuzzleObserver>)puzzleDelegate {
	[self destroyCurrentPuzzle];
	currentPuzzle = [[NetworkPuzzle alloc] initWithDelegate:puzzleDelegate andDifficulty:difficulty];
	return currentPuzzle;//[NetworkPuzzle networkPuzzleWithDelegate:puzzleDelegate andConnection:connection];
}

-(void)recievePuzzleSuccessNotification {
	[currentPuzzle recievePuzzleSuccessNotification];
	[self destroyCurrentPuzzle];
}

-(void)recievePuzzleFailNotification {
	NSLog(@"Got puzzle fail %@", currentPuzzle);
	[currentPuzzle recievePuzzleFailNotification];
	[self destroyCurrentPuzzle];
}

-(void)assignFactory:(Factory *)factory {
	NSNumber* key = [NSNumber numberWithUnsignedInt:factory.objectId];
	[factories setObject:factory forKey:key];
	[super assignFactory:factory];
}

-(void)unassignFactory:(Factory *)factory {
	NSNumber* key = [NSNumber numberWithUnsignedInt:factory.objectId];
	[factories removeObjectForKey:key];
	[super unassignFactory:factory];
}

-(void)recieveEndTurnNotification {
	[self endTurn];
}

-(void)recieveBuildNotification:(MWnetworkBuild *)buildParams {
	
	Factory* factory = [factories objectForKey:[NSNumber numberWithUnsignedInt:buildParams->factoryId]];
	
	[factory buildUnitOfType:buildParams->unitType];
}

-(void)recieveMoveNotivication:(MWNetworkMoveUnit*)moveParams {
	Unit* unit = [self getUnitByID:moveParams->unitId];
	[unit tryToMoveTo:[[MapLoader sharedLoader] getMapObjectByID:moveParams->targetId]];	
}

-(void)startCombat:(Combat *)combat {
	currentCombat = [combat retain];
}

-(void)finishCombat:(Combat *)combat {
	[currentCombat release];
	currentCombat = nil;
}

-(void)reciveUpgradeNotification:(MWNetworkUpgrade*)upgradeParams {
	Factory* factory = [factories objectForKey:[NSNumber numberWithUnsignedInt:upgradeParams->factoryId]];
	[factory upgradeGuardian];
}

-(void)recieveSurrenderNotification {
	[self surrender];
}

-(void)recieveCombatReadyNotification {
	[self readyToNextRoundOfCombat:currentCombat];
}

-(void)dealloc {
	[factories release];
	[connection release];
	[super dealloc];
}

@end

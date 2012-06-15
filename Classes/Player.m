//
//  HumanPlayer.m
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Player.h"
#import "Unit.h"
#import "GameObserver.h"
#import "Factory.h"
#import "PlayerObserver.h"
#import "NoneRestrictions.h"

@implementation Player
@synthesize moveCount, units, restrictions;

-(id)init {
	if (self = [super init]) {
		units = [[NSMutableArray alloc] init];
		observers = [[NSMutableArray alloc] init];
		currentID = 0;
	}
	return self;
}

-(void)startTurn {
	self.moveCount = 1;
	
	if ([restrictions respondsToSelector:@selector(nextTurn)]) {
		[restrictions nextTurn];
	}
	
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(playerStartedTurn:)]) {
			[observer playerStartedTurn:self];
		}
	}
	
}

-(void)endTurn {
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(playerFinishedTurn:)]) {
			[observer playerFinishedTurn:self];
		}
	}
}

-(void)startCombat:(Combat *)combat {
	
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(player:startedCombat:)]) {
			[observer player:self startedCombat:combat];
		}
	}
}

-(Puzzle*)createPuzzleOfDifficulty:(uint32_t)difficulty withDelegate:(id<PuzzleObserver>)delegate {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

-(void)finishCombat:(Combat *)combat {
}

-(void)finishCombatRound:(Combat*)combat {
}

-(void)combatExited {
}

-(void)readyToNextRoundOfCombat:(Combat*)combat {
	[combat playerReady:self];
	
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(player:hasBecomeReadyToNextRoundOfCombat:)]) {
			[observer player:self hasBecomeReadyToNextRoundOfCombat:combat];
		}
	}
}

-(void)assignFactory:(Factory *)factory {

	factoriesAmount++;

	///Warning!!!! Костыль!!!
	[observers insertObject:factory atIndex:0];
	
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(player:assignedFactory:)]) {
			[observer player:self assignedFactory:factory];
		}
	}
}

-(void)surrender {
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(playerSurrendered:)]) {
			[observer playerSurrendered:self];
		}
	}
}

-(void)lose {
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(playerLostTheGame:)]) {
			[observer playerLostTheGame:self];
		}
	}
}

-(void)unassignFactory:(Factory *)factory {
	factoriesAmount--;
	
	[self removeObserver:factory];
	
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(player:unassignedFactory:)]) {
			[observer player:self unassignedFactory:factory];
		}
	}
}

-(void)assignUnit:(Unit *)unit {
	unit.unitID = currentID;
	currentID++;
	[units addObject:unit];
	
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(player:assignedUnit:)]) {
			[observer player:self assignedUnit:unit];
		}
	}
}

-(void)unassignUnit:(Unit *)unit {
	[units removeObject:unit];
}

-(Unit*)getUnitByID:(uint16_t)unitID {
	
	for (Unit* unit in units) {
		if (unit.unitID == unitID) {
			return unit;
		}
	}
	return nil;
}

-(void)addObserver:(id<PlayerObserver>)observer {
	[observers addObject:observer];
}

-(void)removeObserver:(id<PlayerObserver>)observer {
	[observers removeObject:observer];
}

-(NSArray*)units {
	return units;
}

-(void)setMoveCount:(int)value{
	moveCount = value;
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(playerChangedMoveCount:)]) {
			[observer playerChangedMoveCount:self];
		}
	}
}

-(void)showNotification:(NSString *)text {
	for (id<PlayerObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(player:recievedNotification:)]) {
			[observer player:self recievedNotification:text];
		}
	}
}


-(void)dealloc {
	self.restrictions = nil;
	[units release];
	[observers release];
	[super dealloc];
}

@end

//
//  MapLock.m
//  MathWars
//
//  Created by Inf on 03.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MapLock.h"
#import "GameUI.h"


@interface MapLock(Private)

-(void)checkLock;

@end

@implementation MapLock
@synthesize isPlayerTurn, hasActiveCombat, hasActivePuzzle, hasMovingUnit, dialogAtScreen;

-(void)setDefault {
	isPlayerTurn = hasActiveCombat = hasActivePuzzle = hasMovingUnit = dialogAtScreen = NO;
	[self checkLock];
}

-(BOOL)isMapLocked {
	return !isPlayerTurn || hasActiveCombat || hasActivePuzzle || hasMovingUnit || dialogAtScreen;
}

-(void)setIsPlayerTurn:(BOOL)_value {
	isPlayerTurn = _value;
	[self checkLock];
}

-(void)setHasActiveCombat:(BOOL)_value {
	hasActiveCombat = _value;
	[self checkLock];
}

-(void)setHasActivePuzzle:(BOOL)_value {
	hasActivePuzzle = _value;
	[self checkLock];
}

-(void)setHasMovingUnit:(BOOL)_value {
	hasMovingUnit = _value;
	[self checkLock];
}

-(void)setDialogAtScreen:(BOOL)_value {
	dialogAtScreen = _value;
	[self checkLock];
}

@end

@implementation MapLock(Private)

-(void)checkLock {
	if (self.isMapLocked) {
		[[GameUI sharedUI].panel showIdlePanel];
	} else {
		[[GameUI sharedUI].panel showActivePanel];
	}

}

@end
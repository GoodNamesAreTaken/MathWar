//
//  Factory.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Factory.h"

@implementation Factory

@synthesize buildedUnitThisTurn;

-(id)init {
	if (self = [super init]) {
		observers = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)playerStartedTurn:(Player*)player {
	buildedUnitThisTurn = NO;
}

-(void)buildUnitOfType:(uint8_t)type {
	
	if (![owner.restrictions isUnitAvaliable:type]) {
		return;
	}
	
	if (!buildedUnitThisTurn) {
		buildedUnitThisTurn = YES;
		NSLog(@"Factory %@ started building unit:%d", self, type);
		
		BuildingFactoryTask* newTask = [[BuildingFactoryTask alloc] init];
		newTask.factory = self;
		newTask.guardianType = type;
		
		task = newTask;
		
		for (id<FactoryObserver> observer in observers) {
			[observer factory:self startedBuldingUnit:type];
		}
		
		switch (type) {
			case MWUnitTank:
			case MWUnitGunner:
				[owner createPuzzleOfDifficulty:EASY_DIFFICULTY withDelegate:self];
			break;
			case MWUnitCannoneer:
			case MWUnitTitan:
				[owner createPuzzleOfDifficulty:NORMAL_DIFFICULTY withDelegate:self];
			break;
			case MWUnitAnnihilator:
				[owner createPuzzleOfDifficulty:HARD_DIFFICULTY withDelegate:self];
			break;

			default:
				NSLog(@"Trying to build unknown unit");
				break;
		}
	}	
}

-(void)upgradeGuardian {
	
	if (![owner.restrictions isUpgrade:self.guardian.upgrades + 1 avaliableToUnit:self.guardian.type]) {
		return;
	}
	
	task = [[UpdgradingFactoryTask alloc] init];
	task.factory = self;

	buildedUnitThisTurn = YES;
	
	switch (guardian.type) {
		case MWUnitTank:
		case MWUnitGunner:
			if (guardian.upgrades == 0) {
				[owner createPuzzleOfDifficulty:EASY_DIFFICULTY withDelegate:self];	
			} else {
				[owner createPuzzleOfDifficulty:NORMAL_DIFFICULTY withDelegate:self];
			}
			break;
		case MWUnitCannoneer:
		case MWUnitTitan:
			if (guardian.upgrades == 0) {
				[owner createPuzzleOfDifficulty:NORMAL_DIFFICULTY withDelegate:self];	
			} else {
				[owner createPuzzleOfDifficulty:HARD_DIFFICULTY withDelegate:self];
			}
			break;
		case MWUnitAnnihilator:
				[owner createPuzzleOfDifficulty:HARD_DIFFICULTY withDelegate:self];
			break;

		default:
			NSLog(@"Upgrading unknown unit");
			break;
	}
	
	for (id<FactoryObserver> observer in observers) {
		[observer factoryStartedUpgrade:self];
	}
	
	if ([delegate respondsToSelector:@selector(upgradeStarted)]) {
		[delegate upgradeStarted];
	}

}

-(void)puzzleWasSolved:(Puzzle *)puzzle {
	[task doTask];
	
	[task release];
	task = nil;
}

-(void)puzzleWasFailed:(Puzzle *)puzzle {
	[task release];
	task = nil;
}

-(void)onOwnerChange:(Player*)newOwner {
	[owner unassignFactory:self];
	[newOwner assignFactory:self];
	buildedUnitThisTurn = NO;
}


-(void)addObserver:(id<FactoryObserver>)observer {
	[observers addObject:observer];
}

-(void)removeObserver:(id<FactoryObserver>) observer {
	[observers removeObject:observer];
}

-(void)dealloc {
	[observers release];
	[super dealloc];
}

@end

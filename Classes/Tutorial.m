//
//  Tutorial.m
//  MathWars
//
//  Created by Inf on 28.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFMessageBox.h"
#import "Tutorial.h"
#import "RichMessageBoxController.h"
#import "BuildUnitsView.h"
#import "FFGame.h"
#import "GameUI.h"
#import "MapLoader.h"
#import "Move.h"
#import "PuzzleController.h"
#import "HumanPlayer.h"

#define PLAYER_BASE_ID 0
#define ENEMY_BASE_ID 1
#define FACTORY_ID 2
#define SHEILD_ID 3
#define SWAMP_ID 4

uint8_t nextLocations[] = {
	FACTORY_ID,
	-1,
	SHEILD_ID,
	SWAMP_ID,
	ENEMY_BASE_ID,
};

@interface Tutorial(StateCallbacks)

-(void)beginState;
-(void)moveState;
-(void)upgradeState;
-(void)sheildState;
-(void)swampState;
-(void)battleState;
-(void)newUnitState;
-(void)newBattleState;

@end

@interface Tutorial(PostMessageActions)

-(void)switchToBuild;
-(void)showBattleInstructions;

@end

@interface Tutorial(Notifications)

-(void)showBuildButton:(NSNotification*)notification;
-(void)showBuildTank:(NSNotification*)notification;
-(void)puzzleCreated:(NSNotification*)notification;
-(void)puzzleFinished:(NSNotification*)notification;

@end





@implementation Tutorial
@synthesize state;

-(id)init {
	if ((self = [super init])) {
		finger = [[FingerView alloc] init];
		
		stateCallbacks[TSWelcome] = @selector(beginState);
		stateCallbacks[TSBuild] = @selector(buildState);
		stateCallbacks[TSMove] = @selector(moveState);
		stateCallbacks[TSUpgrade] = @selector(upgradeState);
		stateCallbacks[TSSheild] = @selector(sheildState);
		stateCallbacks[TSSwamp] = @selector(swampState);
		stateCallbacks[TSBattle] = @selector(battleState);
		stateCallbacks[TSNewUnit] = @selector(newUnitState);
		stateCallbacks[TSNewBattle] = @selector(newBattleState);
	}
	return self;
}

-(void)setState:(TutorialState)_state {
	state = _state;
	[self performSelector:stateCallbacks[state]];
}

-(void)playerStartedTurn:(Player *)player {
	[self stateActions];
}

-(void)player:(Player *)player assignedUnit:(Unit *)unit {
	if (self.state == TSBuild) {
		self.state = TSMove;
	} else if (state == TSNewUnit) {
		self.state = TSNewBattle;
	}
	[unit addObserver:self];
}

-(void)unit:(Unit *)_unit startedMovingTo:(MapObject *)location withFinishAction:(SEL)action {
}

-(void)unit:(Unit *)unit hasBecomeGuardianOf:(MapObject *)object {
	switch (state) {
		case TSMove:
			if (object.objectId == FACTORY_ID) {
				if ([unit canBeUpgraded]) {
					self.state = TSUpgrade;
				} else {
					self.state = TSSheild;
				}

				
			}
			break;
		case TSUpgrade:
			if (object.objectId == PLAYER_BASE_ID) {
				if ([unit canBeUpgraded]) {
					if (!((Factory*)object).buildedUnitThisTurn) {
						[finger focusOnMapObject:object];
					} else {
						[self showEndTurn];
					}

				}
			} else if (object.objectId = SHEILD_ID) {
				self.state = TSSwamp;
			} else {
				[self stateActions];
			}

			break;

		case TSSheild:
			if (object.objectId == SHEILD_ID) {
				self.state = TSSwamp;
			} else {
				[self stateActions];
			}

			break;
		case TSSwamp:
			if (object.objectId == SWAMP_ID) {
				self.state = TSBattle;
			} else {
				[self stateActions];
			}

			break;

		default:
			break;
	}
}

-(void)unitUpgraded:(Unit *)_unit {
	self.state = TSSheild;
}

-(void)unitDied {
	[finger hide];
	[RichMessageBoxController showWithHeader:@"Unit died" 
							  andPicture:@"buildNormal.png" 
							  andText:@"There is no war without losses. You need another soldiers to finish your task"
							  andAction:@selector(newUnit)
							  andHandler:self];
}

-(void)showMoveTo:(uint8_t)objectId {
	HumanPlayer* player = [[FFGame sharedGame] getModelByName:@"player"];
	
	[finger show];
	if (player.moveCount > 0) {
		if ([self isUnit:player.activeUnit nearestToObject:objectId]) {
			[finger focusOnMapObjectById:nextLocations[player.activeUnit.location.objectId]];
		} else {
			[finger focusOnNearestUnitTo:objectId];
		}
	} else {
		[self showEndTurn];
	}

}

-(BOOL)isUnit:(Unit*)unit nearestToObject:(uint8_t)objectId {
	if (!unit) {
		return NO;
	}
	uint8_t currentId = unit.location.objectId;
    
	while (currentId != objectId) {
		Unit* guardian = [[MapLoader sharedLoader] getMapObjectByID:currentId].guardian;
		if (guardian != nil && guardian != unit) {
			return NO;
		}
		currentId = nextLocations[currentId];
	}
	return YES;
}

-(void)showBuild {
	Factory* factory = (Factory*)[[MapLoader sharedLoader] getMapObjectByID:FACTORY_ID];
	HumanPlayer* player = [[FFGame sharedGame] getModelByName:@"player"];
	[finger show];
	if (factory.owner == player && !factory.buildedUnitThisTurn) {
		[finger focusOnMapObject:factory];
	} else {
		Factory* base = (Factory*)[[MapLoader sharedLoader] getMapObjectByID:PLAYER_BASE_ID];
		if (!base.buildedUnitThisTurn) {
			[finger focusOnMapObject:base];
		} else {
			[self showEndTurn];
		}

	}

}

-(void)showEndTurn {
	if (!endTurnMessageWasShown) {
		endTurnMessageWasShown = YES;
		[finger hide];
		[RichMessageBoxController showWithHeader:@"Finishing your turn" 
									  andPicture:@"endTurnNormal.png" 
										 andText:@"You can't do anythyng useful this turn. Finish it, and next turn you will be able to continue"
									   andAction:@selector(showEndTurn)
									  andHandler:self
		 ];
		
	} else {
		[finger show];
		[finger focusOnView:[GameUI sharedUI].panel.endTurnButton];
	}

}

-(void)showUpgrade {
	Factory* factory = (Factory*)[[MapLoader sharedLoader] getMapObjectByID:FACTORY_ID];
	Factory* base = (Factory*)[[MapLoader sharedLoader] getMapObjectByID:PLAYER_BASE_ID];
	HumanPlayer* player = [[FFGame sharedGame] getModelByName:@"player"];
	[finger show];
	
	if ([factory.guardian canBeUpgraded]) {
		if (factory.buildedUnitThisTurn) {
			[self showEndTurn];
		} else if (player.activeUnit.location == factory) {
			[finger focusOnView:[GameUI sharedUI].panel.upgradeButton];
		} else {
			[finger focusOnMapObject:factory];
		}
	} else if ([base.guardian canBeUpgraded]) {
		if (base.buildedUnitThisTurn) {
			[self showEndTurn];
		} else if (player.activeUnit.location == base) {
			[finger focusOnView:[GameUI sharedUI].panel.upgradeButton];
		} else {
			[finger focusOnMapObject:base];
		}
	}

}

-(void)stateActions {
	switch (state) {
		case TSBegin:
			self.state = TSWelcome;
			break;
		case TSBuild:
		case TSNewUnit:
			[self showBuild];
			break;
		case TSMove:
			[self showMoveTo:FACTORY_ID];
			break;
		case TSUpgrade:
			[self showUpgrade];
			break;
		case TSSheild:
			[self showMoveTo:SHEILD_ID];
			break;
		case TSSwamp:
			[self showMoveTo:SWAMP_ID];
			break;
		case TSBattle:
		case TSNewBattle:
			[self showMoveTo:ENEMY_BASE_ID];
			break;
		default:
			break;
	}
}

-(void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[finger release];
	[super dealloc];
}


@end

@implementation Tutorial(StateCallbacks)

-(void)beginState {
	[RichMessageBoxController showWithHeader:@"Welcome!" 
								  andPicture:@"book.png" 
								  andText:@"Welcome to the training camp, commander! This fast tutorial will guide you through basics of the Math War."
								  andAction:@selector(switchToBuild)
								  andHandler:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(puzzleCreated:) name:@"PuzzleStarted" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(puzzleFinished:) name:@"PuzzleFinished" object:nil];
	[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(stateActions)];
}

-(void)buildState {
	[self showBuild];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBuildButton:) name:@"BuildButtonShown" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateActions) name:@"BuildCanceled" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBuildTank:) name:@"UnitSelectShown" object:nil];
}

-(void)moveState {
	[finger hide];
	[RichMessageBoxController showWithHeader:@"Capturing other objects" 
								  andPicture:@"factory1.png" 
								  andText:@"Great! You succesfuly builded your first tank. Now it's time for war. There is a robot factory near your base. Move your tank there."
								  andAction: @selector(stateActions)
								  andHandler: self
	 ];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateActions) name:@"UnitSelected" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateActions) name:@"UnitDeselected" object:nil];
}

-(void)upgradeState {
	[finger hide];
	[RichMessageBoxController showWithHeader:@"Upgrading Robots" 
								  andPicture:@"upgradeNormal.png" 
								  andText:@"Now you're the owner of this factory. Factories can build or upgrade your soldiers once per turn. Try upgrading your tank. You will need to solve a puzzle"
								  andAction:@selector(stateActions)
								  andHandler:self
	 ];
}

-(void)sheildState {
	[finger hide];
	[RichMessageBoxController showWithHeader:@"Sheild" 
								  andPicture:@"sheild1.png" 
									 andText:@"There is a sheild on the way. Sheild is a kind of bonus building. Capture it and all your soldier will get +1 health"
								   andAction:@selector(stateActions)
								  andHandler:self
	 ];
}

-(void)swampState {
	[finger hide];
	[RichMessageBoxController showWithHeader:@"Swamp" 
							  andPicture:@"swamp.png" 
							  andText:@"Next place to visit is a swamp. Swamp is a kind of obstacle. You need to solve a puzzle while passing an obstacle or your robot will become weaker or die."
							  andAction:@selector(stateActions)
							  andHandler:self
	 ];
}

-(void)battleState {
	[finger hide];
	[RichMessageBoxController showWithHeader:@"Battle"
								  andPicture:@"battle.png" 
									 andText:@"You almost finished your traning. The last you must do is a battle." 
								   andAction:@selector(showBattleInstructions)
								  andHandler:self];
}

-(void)newUnitState {
	[self showBuild];
}

-(void)newBattleState {
	[finger hide];
	[RichMessageBoxController showWithHeader:@"Battle"
								  andPicture:@"battle.png" 
									 andText:@"New tank is ready. It's time to finish the battle." 
								   andAction:@selector(stateActions)
								  andHandler:self];
}

@end

@implementation Tutorial(PostMessageActions)

-(void)switchToBuild {
	self.state = TSBuild;
}

-(void)newUnit {
	HumanPlayer* player = [[FFGame sharedGame] getModelByName:@"player"];
	if (player.units.count > 1) {
		[self showMoveTo:ENEMY_BASE_ID];
	} else {
		self.state = TSNewUnit;
	}

}

-(void)showBattleInstructions {
	[RichMessageBoxController showWithHeader:@"Battle" 
								  andPicture:@"battle.png" 
								  andText:@"At combat, you must solve puzzles faster than your enemy. Unit, whose owner solves puzzle first, attacks. Battle continues till one unit dies."
								  andAction:@selector(stateActions)
								  andHandler:self
	];
}

@end

@implementation Tutorial(Notifications)

-(void)showBuildButton:(NSNotification*)notification {
	if (self.state == TSBuild || self.state == TSRebuild || self.state == TSNewUnit) {
		[finger focusOnView:[GameUI sharedUI].panel.buildButton];
	}
	
}

-(void)showBuildTank:(NSNotification*)notification {
	if (self.state == TSBuild || self.state == TSRebuild || self.state == TSNewUnit) {
		BuildUnitsView* view = (BuildUnitsView*)notification.object;
		[finger focusOnView:view.buildTankButton.buildButton];
	}
}

-(void)puzzleCreated: (NSNotification*) notification{
    PuzzleView* view = ((PuzzleController*)notification.object).view;
    [finger focusOnView:view.rightAnswerButton];
}

-(void)puzzleFinished:(NSNotification*)notification {
	Puzzle* model = ((PuzzleController*)notification.object).model;
	if (model.failed && state == TSBuild) {
		[RichMessageBoxController showWithHeader:@"Build failed" 
								  andPicture:@"buildNormal.png" 
								  andText:@"You failed puzzle and the tank was not built. Please, try again"
								  andAction:@selector(stateActions)
								  andHandler:self
		 ];
	}

}



@end


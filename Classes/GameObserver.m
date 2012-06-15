//
//  GameObserver.m
//  MathWars
//
//  Created by Inf on 16.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "GameObserver.h"
#import "PuzzleBuilder.h"
#import "StandalonePuzzleControllerState.h"
#import "FFGame.h"
#import "GameUI.h"
#import "CombatController.h"
#import "MapLoader.h"
#import "FFMessageBox.h"
#import "NotificationController.h"


static GameObserver* instance;
@implementation GameObserver
@synthesize firstTurn, defaultPuzzleControllerState;

+(GameObserver*)sharedObserver {
	@synchronized(instance) {
		if (instance == nil) {
			instance = [[GameObserver alloc] init];
		}
	}
	return instance;
}

-(id)init {
	if (self = [super init]) {
	}
	return self;
}

-(void)puzzleCreated:(Puzzle *)puzzle {
	
	PuzzleController* controller = [[PuzzleBuilder sharedBuilder] buildViewControllerFromModel:puzzle];
	controller.state = [defaultPuzzleControllerState state];
	
	[[FFGame sharedGame] addController:controller];
}

-(void)playerStartedTurn:(Player*)player {
	if (player == [[FFGame sharedGame] getModelByName:@"player"]) {
		[GameUI sharedUI].lock.isPlayerTurn = YES;
		if (!firstTurn) {
			[[GameUI sharedUI].mapView loadPosition];
		} else {
			firstTurn = NO;
		}

	} else {
		[[GameUI sharedUI].textPanel setMessage:@"Enemy's turn"];
	}

}

-(void)playerChangedMoveCount:(Player *)player {
	if (player == [[FFGame sharedGame] getModelByName:@"player"]) {
		[[GameUI sharedUI].textPanel setMessage:[NSString stringWithFormat:@"Moves: %d", player.moveCount]];
		
		if (player.moveCount == 0) {
			[[GameUI sharedUI].panel.endTurnButton startBlinking];
		} else {
			[[GameUI sharedUI].panel.endTurnButton stopBlinking];
		}

	}
}

-(void)playerFinishedTurn:(Player*)player {
	if (player == [[FFGame sharedGame] getModelByName:@"player"]) {
		//turnSwitcher.player = ;		
		[GameUI sharedUI].lock.isPlayerTurn = NO;
		[[GameUI sharedUI].mapView savePosition];
		

		[[[FFGame sharedGame] getModelByName:@"enemy"] startTurn];
	} else {
		[[[FFGame sharedGame] getModelByName:@"player"] startTurn];
	}
}

-(void)player:(Player*)player startedCombat:(Combat *)combat {
	if (player == [[FFGame sharedGame] getModelByName:@"player"]) {
		CombatView* view = [CombatView combatViewWithUnits:combat.attacker :combat.protector];
		CombatController* controller = [CombatController controllerWithView:view andModel:combat];
		
		[[FFGame sharedGame] addController:controller];
	}
}

-(void)player:(Player *)player recievedNotification:(NSString *)notification {
	if (player == [[FFGame sharedGame] getModelByName:@"player"]) {
		[NotificationController showNotificationWithText:notification andShowingTime:3.0f];
	}
}

-(void)trySurrender {
	[FFMessageBox ofType:MB_YES_NO andText:@"Surrender?" andAction:@selector(surrender) andHandler:[[FFGame sharedGame] getModelByName:@"player"]];
}


@end

//
//  CombatController.m
//  MathWars
//
//  Created by SwinX on 03.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "CombatController.h"
#import "InCombatPuzzleControllerState.h"
#import "GameStarter.h"
#import "PuzzleBuilder.h"
#import "FFGame.h"
#import "GameUI.h"
#import "GameObserver.h"
#import "UnitHelper.h"

@interface CombatController(Private)

-(void)exitCombat;
-(void)viewFinishedAnimation;

@end


@implementation CombatController

+(id)controllerWithView:(CombatView*)combatView andModel:(Combat*)combatModel {
	return [[[CombatController alloc] initWithView:combatView andModel:combatModel] autorelease];
}

-(id)initWithView:(CombatView*)combatView andModel:(Combat*)combatModel {
		
	if (self = [super init]) {
		
		view = [combatView retain];
		soundView = [[CombatUnitSound alloc] initWithAttacker:combatModel.attacker.type andProtector:combatModel.protector.type ];
		model = [combatModel retain];
		[model addObserver:view];
		[model addObserver:soundView];
		
		
		
		[view.animationsFinished addHandler:self andAction:@selector(viewFinishedAnimation)];
		
		[view.attackerStartedMoving addHandler:self andAction:@selector(attackerStartedMoving)];
		[view.attackerFinishedMoving addHandler:self andAction:@selector(attackerFinishedMoving)];
		[view.protectorStartedMoving addHandler:self andAction:@selector(protectorStartedMoving)];
		[view.protectorFinishedMoving addHandler:self andAction:@selector(protectorFinishedMoving)];
		
	}
	return self;
}

-(void)addedToGame {
	[[GameUI sharedUI].mapView hide];
	[GameUI sharedUI].lock.hasActiveCombat = YES;
	[[[FFGame sharedGame] getModelByName:@"player"] setPuzzleCreationDelegate:self];
	[view show];
}

-(void)removedFromGame {
	
	[[GameUI sharedUI].mapView show];

	[view hide];
	[GameUI sharedUI].lock.hasActiveCombat = NO;
	
	[[[FFGame sharedGame] getModelByName:@"player"] setPuzzleCreationDelegate:[GameObserver sharedObserver]];
}

-(void)exitCombat {
	[[FFGame sharedGame] removeController:self];
	[model combatExited];
	if (![[GameUI sharedUI].lock isPlayerTurn]) {
		[[GameUI sharedUI].textPanel setMessage:@"Enemy's turn"];
	} else {
		[[GameUI sharedUI].textPanel showMovesCount];
	}

}

-(void)viewFinishedAnimation {
	if (!model.isFinished) {
		[[[FFGame sharedGame] getModelByName:@"player"] readyToNextRoundOfCombat:model];
	} else {
		FFTimer* timer = [[FFGame sharedGame].timerManager getTimerWithInterval:2.0f andSingleUse:YES];
		[timer.action addHandler:self andAction:@selector(exitCombat)];
		//[view addExitButton];
	}
}

-(void)attackerStartedMoving {
	attackerSound = [[[FFGame sharedGame].soundManager getSound:[[UnitHelper sharedHelper] getMoveSoundOf:model.attacker.type]] retain];
	[attackerSound loop];
}

-(void)attackerFinishedMoving {
	[attackerSound stop];
}

-(void)protectorStartedMoving {
	if (model.protector.type != model.attacker.type) {
		protectorSound = [[[FFGame sharedGame].soundManager getSound:[[UnitHelper sharedHelper] getMoveSoundOf:model.protector.type]] retain];
		[protectorSound loop];
	}
}

-(void)protectorFinishedMoving {
	[protectorSound stop];
}

-(void)puzzleCreated:(Puzzle *)puzzle {
	PuzzleController* controller = [[PuzzleBuilder sharedBuilder] buildViewControllerFromModel:puzzle];
	
	controller.state = [InCombatPuzzleControllerState state];
	view.puzzle = controller.view;
	
	[[FFGame sharedGame] addController:controller];
}

-(void)dealloc {
	
	[view release];
	[soundView release];
	[model release];
	
	[attackerSound release];
	[protectorSound release];
	[super dealloc];
	
}

@end
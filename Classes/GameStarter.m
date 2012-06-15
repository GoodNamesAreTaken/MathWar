//
//  GameManager.m
//  MathWars
//
//  Created by Inf on 02.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "GameStarter.h"
#import "FFGame.h"
#import "NetworkPlayer.h"
#import "AIPlayer.h"
#import "GameUI.h"
#import "MapLoader.h"
#import "MapFinisher.h"
#import "CampaignRestrictions.h"
#import "Tutorial.h"
#import "TutorialAI.h"
#import "TutorialResrictions.h"
#import "StandalonePuzzleControllerState.h"
#import "InCombatPuzzleControllerState.h"
#import "CampaignAIRestrictions.h"

@implementation GameStarter

+(id)starter {
	return [[[GameStarter alloc] init] autorelease];
}

-(void)setUpPlayers {
	
	if (!player.restrictions) {
		player.restrictions = [CampaignRestrictions restrictionsWithCampaign:[[FFGame sharedGame] getModelByName:@"campaign"]];
	}
	
	if (!enemy.restrictions) {
		enemy.restrictions = [CampaignRestrictions restrictionsWithCampaign:[[FFGame sharedGame] getModelByName:@"campaign"]];
	}
	
	[[FFGame sharedGame] registerModel:player withName:@"player"];
	[[FFGame sharedGame] registerModel:enemy withName:@"enemy"];
	
	[[GameObserver sharedObserver] setFirstTurn:YES];
	
	[[GameUI sharedUI].panel.endTurnButton.click addHandler:player andAction:@selector(endTurn)];
	[[GameUI sharedUI].panel.surrenderButton.click addHandler:[GameObserver sharedObserver] andAction:@selector(trySurrender)];
	[player addObserver:[GameObserver sharedObserver]];
	player.puzzleCreationDelegate = [GameObserver sharedObserver];
	
	[enemy addObserver:[GameObserver sharedObserver]];
	
	[player addObserver:[MapFinisher sharedFinisher]];
	[enemy addObserver:[MapFinisher sharedFinisher]];
}

-(void)setUpNetworkPlayersWithConnection:(GameKitConnection*)connection {
	[self setUpPlayers];
	[player addObserver:connection];
}

-(void)startMission:(NSString*)missionFile {
	player = [[HumanPlayer alloc] init];
	enemy = [[AIPlayer alloc] init];
	enemy.restrictions = [CampaignAIRestrictions restrictionsWithCampaign:[[FFGame sharedGame] getModelByName:@"campaign"]];
	
 	[self setUpPlayers];
	[GameObserver sharedObserver].defaultPuzzleControllerState = [StandalonePuzzleControllerState class];
	[[MapLoader sharedLoader] loadFromFile:missionFile withPlayer:player andEnemy:enemy];
	[[GameUI sharedUI] buildMapViewForPlayer:player andEnemy:enemy];
	
	
	[player startTurn];
}

-(void)startTutorial {
	player = [[HumanPlayer alloc] init];
	enemy = [[TutorialAI alloc] init];
	
	player.restrictions = [TutorialResrictions restrictions];
	[self setUpPlayers];
	
	[GameObserver sharedObserver].defaultPuzzleControllerState = [InCombatPuzzleControllerState class];
	
	[[MapLoader sharedLoader] loadFromFile:@"tutorial" withPlayer:player andEnemy:enemy];
	
	Tutorial* tutorial = [[[Tutorial alloc] init] autorelease];
	[player addObserver:tutorial];
	
	[[GameUI sharedUI] buildMapViewForPlayer:player andEnemy:enemy];
	[player startTurn];
}


-(void)startRandomGame {
	player = [[HumanPlayer alloc] init];
	enemy = [[AIPlayer alloc] init];
	
	[self setUpPlayers];
	[GameObserver sharedObserver].defaultPuzzleControllerState = [StandalonePuzzleControllerState class];
	[[MapLoader sharedLoader] loadRandomWithObjectCount:8 player:player andEnemy:enemy];
	[[GameUI sharedUI] buildMapViewForPlayer:player andEnemy:enemy];
	
	[player startTurn];
}

-(void)startNetworkGameAsServerWithConnection:(GameKitConnection*)connection {
	player = [[HumanPlayer alloc] init];
	enemy = [[NetworkPlayer alloc] initWithConnection:connection];
	
	[self setUpNetworkPlayersWithConnection:connection];
	[GameObserver sharedObserver].defaultPuzzleControllerState = [StandalonePuzzleControllerState class];
	[[MapLoader sharedLoader] loadRandomWithObjectCount:8 player:player andEnemy:enemy];
	[connection sendMap:[MapLoader sharedLoader].mapTemplate];
	
	[[GameUI sharedUI] buildMapViewForPlayer:player andEnemy:enemy];
	[player startTurn];
}

-(void)recieveMap:(NSValue*)valueWithParams fromConnection:(GameKitConnection*)connection {
	player = [[HumanPlayer alloc] init];
	enemy = [[NetworkPlayer alloc] initWithConnection:connection];
	
	MWNetWorkMapParams* mapParams = [valueWithParams pointerValue];
	
	[self setUpNetworkPlayersWithConnection:connection];
	[GameObserver sharedObserver].defaultPuzzleControllerState = [StandalonePuzzleControllerState class];
	[[MapLoader sharedLoader] loadFromNetworkParams:mapParams withPlayer:[[FFGame sharedGame] getModelByName:@"player"] andEnemy:[[FFGame sharedGame] getModelByName:@"enemy"]];
	
	free(mapParams);
	[[GameUI sharedUI] buildMapViewForPlayer:player andEnemy:enemy];
	
	[enemy startTurn];
	
}

-(void)dealloc {
	[player release];
	[enemy release];
	[super dealloc];
}
@end

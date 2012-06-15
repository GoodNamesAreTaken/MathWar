//
//  GameManager.h
//  MathWars
//
//  Created by Inf on 02.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//


#import "GameKitConnection.h"
#import "GameObserver.h"
#import "HumanPlayer.h"

@interface GameStarter : NSObject {
	HumanPlayer* player;
	Player* enemy;
}

+(id)starter;

-(void)setUpPlayers;
-(void)setUpNetworkPlayersWithConnection:(GameKitConnection*)connection;
-(void)startMission:(NSString*)missionFile;
-(void)startTutorial;
-(void)startRandomGame;
-(void)startNetworkGameAsServerWithConnection:(GameKitConnection*)connection;

@end

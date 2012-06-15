//
//  NetworkPlayer.h
//  MathWars
//
//  Created by Inf on 11.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "GameKitConnection.h"
#import "Player.h"
#import "NetworkPuzzle.h"


@interface NetworkPlayer : Player<MessageDelegate> {
	GameKitConnection* connection;
	
	NetworkPuzzle* currentPuzzle;
	Combat* currentCombat;
	NSMutableDictionary* factories;
}

-(id)initWithConnection:(GameKitConnection*) gameConnection;
-(void)destroyCurrentPuzzle;

@end

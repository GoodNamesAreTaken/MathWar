//
//  GameGitConnection.h
//  MathWars
//
//  Created by Inf on 09.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "NetworkProtocol.h"
#import "PlayerObserver.h"
#import "Puzzle.h"
#import "Unit.h"
#import "Factory.h"

@class GameKitConnection;
@protocol MessageDelegate<NSObject>

@optional
-(void)recieveMap:(MWNetWorkMapParams*)mapParams/*(NSValue*)valueWithParams*/ fromConnection:(GameKitConnection*)connection;

-(void)recieveBuildNotification:(MWnetworkBuild*)buildParams;
-(void)reciveUpgradeNotification:(MWNetworkUpgrade*)upgradeParams;

-(void)recieveEndTurnNotification;
-(void)recieveMoveNotivication:(MWNetworkMoveUnit*)moveParams;

-(void)recievePuzzleSuccessNotification;
-(void)recievePuzzleFailNotification;
-(void)recieveSurrenderNotification;
-(void)recieveCombatReadyNotification;

@end

@interface GameKitConnection : NSObject<GKSessionDelegate, PlayerObserver, FactoryObserver, PuzzleObserver, UnitObserver> {
	id<MessageDelegate> messageDelegate;
	GKSession* session;
}

@property(assign) id<MessageDelegate> messageDelegate;
@property(readonly) GKSession*  session;

-(id)initWithSessionMode:(GKSessionMode)mode;
-(void)sendMap:(MWNetWorkMapParams*)mapParams;
-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context;
-(void)destroySession;



@end

//
//  GameGitConnection.m
//  MathWars
//
//  Created by Inf on 09.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "GameKitConnection.h"

#import "FFGame.h"
#import "StartMenuController.h"
#import "GameUI.h"
#import "MissionPreloaderController.h"
#import "GameStarter.h"
#import "MapFinisher.h"

#define SESSION_ID @"MathWars_1.0"

@implementation GameKitConnection
@synthesize messageDelegate;
@synthesize session;

-(id)initWithSessionMode:(GKSessionMode)mode {
	if (self = [super init]) {
		session = [[GKSession alloc] initWithSessionID:SESSION_ID displayName:[UIDevice currentDevice].name sessionMode:mode];
		session.delegate = self;
		session.available = YES;
		
		session.disconnectTimeout = 10.0f;
		[session setDataReceiveHandler:self withContext:nil];
		
	}
	return self;
}

-(void)convertAndNotiftyMap:(MWNetWorkMapParams*) params {
	MWNetWorkMapParams* copy = malloc(sizeof(MWNetWorkMapParams));
	*copy = *params;
	for (int i=0; i<copy->objectCount; i++) {
		if (copy->objects[i].owner == 1) {
			copy->objects[i].owner = 2;
		} else if (copy->objects[i].owner == 2) {
			copy->objects[i].owner = 1;
		}
	}
	[messageDelegate recieveMap:copy fromConnection:self];
}

-(void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
	if (state == GKPeerStateDisconnected) {
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enemy have disconnected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		[[MapFinisher sharedFinisher] finalizeMission];
		[[FFGame sharedGame] addController:[StartMenuController controller]];
	}
}

-(void)session:(GKSession *)session didFailWithError:(NSError *)error {
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Game session error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	
	[[MapFinisher sharedFinisher] finalizeMission];
	[[FFGame sharedGame] addController:[StartMenuController controller]];
}

-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
	uint8_t* message = (uint8_t*)[data bytes];
	
	switch (message[0]) {
		case MWNetworkMessageSendMap: 
			[self convertAndNotiftyMap:(MWNetWorkMapParams*)&message[1]];
			break;
		case MWNetworkMessageTurnEnded:
			[messageDelegate recieveEndTurnNotification];
			break;
		case MWNetworkMessagePuzzleSolved:
			[messageDelegate recievePuzzleSuccessNotification];
			break;
		case MWNetworkMessagePuzzleFailed:
			[messageDelegate recievePuzzleFailNotification];
			break;
		case MWNetworkMessageBuildingStarted:
			[messageDelegate recieveBuildNotification:(MWnetworkBuild*)&message[1]];
			break;
		case MWNetworkMessageUnitMoved:
			[messageDelegate recieveMoveNotivication:(MWNetworkMoveUnit*)&message[1]];
			break;
		case MWNetworkMessageUpgradeStarted:
			[messageDelegate reciveUpgradeNotification:(MWNetworkUpgrade*)&message[1]];
			break;
		case MWNetworkMessageSurrender:
			[messageDelegate recieveSurrenderNotification];
		case MWNetworkMessageReadyToNextCombatRound:
			[messageDelegate recieveCombatReadyNotification];
			break;
		default:
			NSLog(@"Invalid message: %d", message[0]);
	}
}

-(void)setMessageDelegate:(id<MessageDelegate>)delegate {
	messageDelegate = delegate;
}

-(void)sendMap:(MWNetWorkMapParams *)mapParams {
	NSLog(@"Map sent");
	uint8_t bytes[sizeof(MWNetWorkMapParams) + 1];
	bytes[0] = MWNetworkMessageSendMap;
	
	memcpy(bytes +1, mapParams, sizeof(MWNetWorkMapParams));
	
	[session sendDataToAllPeers:[NSData dataWithBytes:bytes length:sizeof(MWNetWorkMapParams) + 1] withDataMode:GKSendDataReliable error:nil];
}

-(void)playerFinishedTurn:(Player*)player {
	uint8_t message = MWNetworkMessageTurnEnded;
	
	[session sendDataToAllPeers:[NSData dataWithBytes:&message length:1] withDataMode:GKSendDataReliable error:nil];
}

-(void)player:(Player*)player assignedFactory:(Factory *)factory {
	[factory addObserver:self];
}

-(void)player:(Player*)player unassignedFactory:(Factory *)factory {
	[factory removeObserver:self];
}

-(void)player:(Player*)player assignedUnit:(Unit *)unit {
	[unit addObserver:self];
}

-(void)unit:(Unit*)_unit startedMovingTo:(MapObject*)location withFinishAction:(SEL)action {
	uint8_t message[sizeof(MWNetworkMoveUnit) + 1];
	MWNetworkMoveUnit* params = (MWNetworkMoveUnit*)&message[1];
	message[0] = MWNetworkMessageUnitMoved;
	params->unitId = _unit.unitID;
	params->targetId = location.objectId;
	
	[session sendDataToAllPeers:[NSData dataWithBytes:message length:sizeof(MWNetworkMoveUnit) + 1] withDataMode:GKSendDataReliable error:nil];
}

-(void)player:(Player*)player hasBecomeReadyToNextRoundOfCombat:(Combat*)combat {
	uint8_t message = MWNetworkMessageReadyToNextCombatRound;
	[session sendDataToAllPeers:[NSData dataWithBytes:&message length:1] withDataMode:GKSendDataReliable error:nil];
}

-(void)player:(Player*)player createdPuzzle:(Puzzle *)puzzle {
	[puzzle addObserver:self];
}

-(void)factory:(Factory *)factory startedBuldingUnit:(uint8_t)unitType {
	uint8_t message[sizeof(MWnetworkBuild) + 1];
	MWnetworkBuild* params = (MWnetworkBuild*)&message[1];
	message[0] = MWNetworkMessageBuildingStarted;
	params->factoryId = factory.objectId;
	params->unitType = unitType;
	
	NSLog(@"MWNetworkMessageBuildingStarted sent");
	[session sendDataToAllPeers:[NSData dataWithBytes:message length:sizeof(MWnetworkBuild) + 1] withDataMode:GKSendDataReliable error:nil];
}

-(void)factoryStartedUpgrade:(Factory *)factory {
	uint8_t message[sizeof(MWNetworkUpgrade) + 1];
	MWNetworkUpgrade* params = (MWNetworkUpgrade*)&message[1];
	message[0] = MWNetworkMessageUpgradeStarted;
	params->factoryId = factory.objectId;
	
	[session sendDataToAllPeers:[NSData dataWithBytes:message length:sizeof(MWNetworkUpgrade) + 1] withDataMode:GKSendDataReliable error:nil];
}

-(void)puzzleWasSolved:(Puzzle *)puzzle {
	uint8_t message = MWNetworkMessagePuzzleSolved;
	
	[session sendDataToAllPeers:[NSData dataWithBytes:&message length:1] withDataMode:GKSendDataReliable error:nil];
}

-(void)puzzleWasFailed:(Puzzle *)puzzle {
	uint8_t message = MWNetworkMessagePuzzleFailed;
	
	NSData* data = [NSData dataWithBytes:&message length:1];
	[session sendDataToAllPeers:data withDataMode:GKSendDataReliable error:nil];
	NSLog(@"Fail message sent. Puzzle: %@", puzzle);
}

-(void)playerSurrendered:(Player*)player {
	uint8_t message = MWNetworkMessageSurrender;
	NSData* data = [NSData dataWithBytes:&message length:1];
	[session sendDataToAllPeers:data withDataMode:GKSendDataReliable error:nil];
}

-(void)destroySession {
	session.available = NO;
	[session disconnectFromAllPeers];
	[session release];
	session = nil;
}

-(void)dealloc {
	[self destroySession];
	[super dealloc];
}

@end

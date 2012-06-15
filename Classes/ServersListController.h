//
//  ServersListController.h
//  MathWars
//
//  Created by Inf on 11.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFUIKitAdapter.h"
#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "GameKitConnection.h"


@interface ServersListController : FFUIKitAdapter<UITableViewDataSource, GKSessionDelegate> {
	
	GameKitConnection* connection;
	NSMutableArray* peers;
	
	IBOutlet UIButton* joinButton;
	IBOutlet UITableView* table;
	IBOutlet UIView* peerWaitingView;
}
@property(nonatomic, retain) UITableView* table;
@property(nonatomic, retain) UIButton* joinButton;
@property(nonatomic, retain) UIView* peerWaitingView;

+(id)controller;

-(IBAction)createServer;
-(IBAction)createClient;
-(IBAction)connect;
-(IBAction)cancel;
-(IBAction)clientButtonClicked;

-(void)destroySession;

@end

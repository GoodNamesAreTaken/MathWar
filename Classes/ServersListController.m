//
//  ServersListController.m
//  MathWars
//
//  Created by Inf on 11.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "ServersListController.h"
#import "GameKitConnection.h"
#import "GameStarter.h"
#import "FFGame.h"
#import "StartMenuController.h"
#import "MissionPreloaderController.h"
#import "PlaySound.h"

@implementation ServersListController
@synthesize table;
@synthesize joinButton, peerWaitingView;

+(id)controller {
	return [[[ServersListController alloc] init] autorelease];
}

-(id)init {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		return [super initWithNibName:@"ServersList-iPad" bundle:nil];
	}
	return [super initWithNibName:@"ServersList" bundle:nil];
}

-(void)viewDidLoad {
	peers = [[NSMutableArray alloc] init];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self createClient];

}

-(IBAction)clientButtonClicked {
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:@"menuClick"]];
	[self createClient];
}

-(IBAction)createClient {
	if (connection.session.sessionMode != GKSessionModeClient) {
		[self destroySession];
		[peerWaitingView removeFromSuperview];
		connection = [[GameKitConnection alloc] initWithSessionMode:GKSessionModeClient];
		connection.session.delegate = self;
		joinButton.enabled = NO;
		
	}
}

-(IBAction)createServer {
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:@"menuClick"]];
	if (connection.session.sessionMode != GKSessionModeServer) {
		[self destroySession];
		connection = [[GameKitConnection alloc] initWithSessionMode:GKSessionModeServer];
		connection.session.delegate = self;
		joinButton.enabled = NO;
		[self.view addSubview:peerWaitingView];
	}	
}

-(void)destroySession {
	
	[connection release];
	connection = nil;
	[peers removeAllObjects];
	[table reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

-(void)session:(GKSession *)_session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
	
	switch (state) {
		case GKPeerStateAvailable:
			[peers addObject:peerID];
			[table reloadData];
			joinButton.enabled = YES;
			break;
		case GKPeerStateUnavailable:
			[peers removeObject:peerID];
			[table reloadData];
			if (peers.count == 0) {
				joinButton.enabled = NO;
			}
			break;
		case GKPeerStateConnected:
			connection.session.available = NO;
			
			connection.session.delegate = connection;
			[[FFGame sharedGame].soundManager stopBGM];
			[[FFGame sharedGame] removeController:self];
			if (_session.sessionMode == GKSessionModeServer) {
				[MissionPreloaderController preloadGameAsServerWithConnection:connection];
			} else {
				[MissionPreloaderController preloadGameAsClientWithConnection:connection];
			}
			[self destroySession];
			break;
	}
	
}

-(void)session:(GKSession *)_session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
	NSError* error;
	[_session acceptConnectionFromPeer:peerID error:&error];
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PeerCell"];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero
									   reuseIdentifier:@"PeerCell"] autorelease];
    }
	
    cell.textLabel.text = (NSString *)[connection.session displayNameForPeer:[peers objectAtIndex:indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return peers.count;
}

-(void)session:(GKSession *)session didFailWithError:(NSError *)error {
	if (error.code == GKSessionCannotEnableError) {
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enable bluetooth or WiFi to be able to play with friends" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

-(IBAction)connect {
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:@"menuClick"]];
	if (table.indexPathForSelectedRow != nil) {
		NSString* peerId = [peers objectAtIndex:table.indexPathForSelectedRow.row];
		[connection.session connectToPeer:peerId withTimeout:10.0f];
	}
	
}


-(IBAction)cancel {
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:@"menuClick"]];
	[self destroySession];
	[[FFGame sharedGame] removeController:self];
	[[FFGame sharedGame] addController:[StartMenuController controller]]; 
}

-(void)removedFromGame {
	[super removedFromGame];
}

-(void)dealloc {
	[self destroySession];
	
	self.table = nil;
	self.joinButton = nil;
	self.peerWaitingView = nil;
	[peers release];
	[super dealloc];
}

@end

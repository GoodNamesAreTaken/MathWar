//
//  StartMenuController.m
//  MathWars
//
//  Created by Inf on 10.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "StartMenuController.h"

#import "HumanPlayer.h"
#import "AIPlayer.h"
#import "GameStarter.h"
#import "GameKitConnection.h"
#import "FFGame.h"
#import "CampaignController.h"
#import "Campaign.h"
#import "ServersListController.h"
#import "MissionPreloaderController.h"
#import "RichMessageBoxController.h"
#import "FFMessageBox.h"
#import "MapObjectsInfo.h"
#import "MineField.h"

@interface StartMenuController(Private)
-(BOOL)tutorialPassed;
-(void) startCampaign;
-(void) singleGame;
@end

@implementation StartMenuController

+(id)controller {
	return [[[StartMenuController alloc] init] autorelease];
}

-(id)init {
	if (self = [super init]) {
		view = [[StartMenuView alloc] init];
		[view.startCampaign.click addHandler:self andAction:@selector(tryStartCampaign)];
		[view.startSingleGame.click addHandler:self andAction:@selector(tryStartSingleGame)];
		[view.startMultiplayer.click addHandler:self andAction:@selector(multiplayer)];
		[view.tutorial.click addHandler:self andAction:@selector(tutorial)];
		//[[MapObjectsInfo info] reset];
	}
	return self;
}

-(void)addedToGame {
	[view show];
	[[FFGame sharedGame].soundManager playBackgroundMusic:@"theme.caf" once:NO];
}

-(void)removedFromGame {
	[view hide];
}

-(void)tryStartCampaign {
    
    if (![self tutorialPassed]) {
        [FFMessageBox ofType:MB_YES_NO andText:@"You didn't learn tutorial! Would you like to pass it now?" andYesAction:@selector(tutorial) andNoAction:@selector(startCampaign) andHandler:self];
    } else {
        [self startCampaign];
    }
}

-(void)tryStartSingleGame {
    if (![self tutorialPassed]) {
        [FFMessageBox ofType:MB_YES_NO andText:@"You didn't learn tutorial! Would you like to pass it now?" andYesAction:@selector(tutorial) andNoAction:@selector(singleGame) andHandler:self];
    } else {
        [self singleGame];
    }    
}

-(void) startCampaign {
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialPassed"];
	[[FFGame sharedGame] removeController:self];
	[[FFGame sharedGame] addController:[CampaignController controller]];
	((Campaign*)[[FFGame sharedGame] getModelByName:@"campaign"]).playingCampaign = YES;
}

-(void)tutorial {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialPassed"];
	[[FFGame sharedGame] removeController:self];
	((Campaign*)[[FFGame sharedGame] getModelByName:@"campaign"]).playingCampaign = NO;
	[[FFGame sharedGame].soundManager stopBGM];
	[MissionPreloaderController startTutorial];
}

-(void)singleGame {
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialPassed"];
	[[FFGame sharedGame] removeController:self];
	[MissionPreloaderController preloadRandomGame];
	((Campaign*)[[FFGame sharedGame] getModelByName:@"campaign"]).playingCampaign = NO;
	[[FFGame sharedGame].soundManager stopBGM];
}
 
-(void)multiplayer {
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialPassed"];
	[[FFGame sharedGame] removeController:self];
 	[[FFGame sharedGame] addController:[ServersListController controller]];
	((Campaign*)[[FFGame sharedGame] getModelByName:@"campaign"]).playingCampaign = NO;
}

-(BOOL)tutorialPassed {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"tutorialPassed"];
}

-(void)dealloc {
	[view release];
	[super dealloc];
}

@end

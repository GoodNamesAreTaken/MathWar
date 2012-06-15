//
//  MissionLoadscreenController.m
//  MathWars
//
//  Created by SwinX on 03.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MissionPreloaderController.h"
#import "FFGame.h"
#import "GameStarter.h" 
#import "PlaySound.h"

@interface MissionPreloaderController(Private)

-(void)tryShowMission;

@end

@implementation MissionPreloaderController

@synthesize model;

+(void)startTutorial {
	MissionPreloaderController* controller = [[MissionPreloaderController alloc] init];
	[controller.model startTutorialWithAfterStartAction:@selector(loadingFinished) ofObject:controller];
	[[FFGame sharedGame] addController:[controller autorelease]];
}

+(void)preloadMission:(NSString*)mission {
	MissionPreloaderController* controller = [[MissionPreloaderController alloc] init];
	[controller.model startMissionNamed:mission withAfterStartAction:@selector(loadingFinished) ofObject:controller];
	[[FFGame sharedGame] addController:[controller autorelease]];
}

+(void)preloadRandomGame {
	MissionPreloaderController* controller = [[MissionPreloaderController alloc] init];
	[controller.model startRandomGameWithAfterStartAction:@selector(loadingFinished) ofObject:controller];
	[[FFGame sharedGame] addController:[controller autorelease]];
}

+(void)preloadGameAsServerWithConnection:(GameKitConnection*)connection {
	MissionPreloaderController* controller = [[MissionPreloaderController alloc] init];
	[controller.model startNetworkGameAsServerFromConnection:connection withAfterStartAction:@selector(loadingFinished) ofObject:controller];
	[[FFGame sharedGame] addController:[controller autorelease]];
}

+(void)preloadGameAsClientWithConnection:(GameKitConnection*)connection {
	MissionPreloaderController* controller = [[MissionPreloaderController alloc] init];
	controller.model.secondArgument = connection;
	controller.model.afterLoadAction = @selector(loadingFinished);
	controller.model.afterLoadSender = controller;
	connection.messageDelegate = controller.model;
	[[FFGame sharedGame] addController:[controller autorelease]];
}



-(id)init {
	if (self = [super init]) {
		
		model = [[MissionPreloader alloc] init];
		view = [[MissionPreloaderView alloc] initWithHint:[MissionPreloader randomHint]];
		[view.event addHandler:self andAction:@selector(destroySelf)];
		
		timer = [[FFGame sharedGame].timerManager getTimerWithInterval:3.0f andSingleUse:YES];
		[timer.action addHandler:self andAction:@selector(waitOver)];
		
		timerOver = NO;
		
		backSound = [[[FFGame sharedGame].soundManager getSound:@"preloader"] retain];
		
	}
	return self;
}

-(void)destroySelf {
	[[FFGame sharedGame] removeController:self];
}

-(void)addedToGame {
	[backSound loop];
	[view show];
}

-(void)removedFromGame {
	[view hide];
}

-(void)loadingFinished {
	missionPreloaded = YES;
	[self tryShowMission];
}

-(void)waitOver {
	timerOver = YES;
	[self tryShowMission];
}

-(void)tryShowMission {
	if (timerOver && missionPreloaded) {
		[backSound stop];
		
		[[FFGame sharedGame].actionManager addAction:[PlaySound named:@"preloaderEnd"]];
		[view openMission];
	}	
}

-(void)dealloc {
	[backSound release];
	[model release];
	[view release];
	[super dealloc];
}

@end

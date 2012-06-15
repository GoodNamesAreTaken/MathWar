//
//  Campaign.m
//  MathWars
//
//  Created by SwinX on 18.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Campaign.h"
#import "FFGame.h"
#import "MissionPreloaderController.h"
#import "WinCampaignController.h"
 
#define MISSIONS_FILE_NAME @"missions"

@interface Campaign(Private)

-(void)campaignComplete;

@end

@implementation Campaign

@synthesize missionsOpened, currentMission, missionsAmount, playingCampaign;

-(id)init {
	if (self = [super init]) {
		NSString* path = [[NSBundle mainBundle] pathForResource:MISSIONS_FILE_NAME ofType:@"plist"];
		missionNames = [[NSArray alloc] initWithContentsOfFile:path];
		
		missionsAmount = [missionNames count];
		currentMission = 1;
		
	}
	return self;
}

-(void)beginMission:(int)mission { 
	currentMission = mission;
	[MissionPreloaderController preloadMission:[missionNames objectAtIndex:mission - 1]];
}

-(void)nextMission {
	
	if (currentMission >= self.missionsOpened && currentMission < self.missionsAmount) {
		self.missionsOpened++;
	}
	
	currentMission++;
	
	if (currentMission > missionsAmount) {
		[self campaignComplete];
	} else {
		[self beginMission:currentMission];
	}
	
}

-(int)missionsOpened {
	int opened = [[NSUserDefaults standardUserDefaults] integerForKey:@"missionsOpened"];
	return MAX(opened, 1);
}

-(void)setMissionsOpened:(int)value {
	[[NSUserDefaults standardUserDefaults] setInteger:value forKey:@"missionsOpened"];
}

-(void)campaignComplete {
	playingCampaign = NO;
	[WinCampaignController epicWin];
	//тут торжественный пыщьпыщь
}

-(void)dealloc {
	[super dealloc];
}

@end

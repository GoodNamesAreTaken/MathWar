//
//  MapFinisher.m
//  MathWars
//
//  Created by SwinX on 21.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MapFinisher.h"
#import "FFGame.h"
#import "GameUI.h"
#import "FFMessageBox.h"
#import "StartMenuController.h"
#import "MapLoader.h"
#import "UnitHelper.h"
#import "RichMessageBoxController.h"

static MapFinisher* mapFinisher = nil;

@interface MapFinisher(Private)

-(void)playerLostMission:(Player*)player;
-(void)playerLostMissionInCampaign;
-(void)getPlayerAndCampaign;
-(void)finishGame;
-(void)wonCampignMission;
-(void)showAnihillatorMessage;

@end

@implementation MapFinisher

@synthesize looser;

+(MapFinisher*)sharedFinisher {
	@synchronized(self) {
	
		if (mapFinisher == nil) {
			mapFinisher = [[MapFinisher alloc] init];
		}
		
	}
	return mapFinisher;
}

-(id)init {
	if (self = [super init]) {
		winSound = [[[FFGame sharedGame].soundManager getSound:@"missionWin"] retain];
		loseSound = [[[FFGame sharedGame].soundManager getSound:@"missionLose"] retain];
	}
	return self;
}

-(void)playerLostTheGame:(Player*)player {
	
	looser = player;
	
	[self getPlayerAndCampaign];
	if (player == humanPlayer) {
		[FFMessageBox ofType:MB_OK andText:@"You lose" andAction:@selector(finishGame) andHandler:self];
		[loseSound play];
	} else {
		
		if (campaign.playingCampaign) {
			[self wonCampignMission];
		} else {
			[FFMessageBox ofType:MB_OK andText:@"You win" andAction:@selector(finishGame) andHandler:self];
		}

		
		[winSound play];
	}
}

-(void)playerSurrendered:(Player *)player {
	[self playerLostTheGame:player];
}

-(void)finishGame {
	[self finalizeMission];
	
	if (campaign.playingCampaign) {
		[self playerLostMissionInCampaign];
	} else {
		[[FFGame sharedGame] addController:[StartMenuController controller]];
	}
}

-(void)playerLostMissionInCampaign {
	if (humanPlayer == looser) {
		campaign.playingCampaign = NO;
		[[FFGame sharedGame] addController:[StartMenuController controller]];
	} else {
		[campaign nextMission];
	}
}

-(void)getPlayerAndCampaign {
	
	humanPlayer = [[FFGame sharedGame] getModelByName:@"player"];
	campaign = [[FFGame sharedGame] getModelByName:@"campaign"];
}

-(void)wonCampignMission {
	
	if (campaign.currentMission == campaign.missionsAmount) {
		[RichMessageBoxController showWithHeader:@"Mission Complete" 
									  andPicture:@"barricades.png" 
										 andText:@"Congratulations! You conquered the last enemy stronghold. The war seems to go to an end." 
									   andAction:@selector(finishGame) 
									  andHandler:self];
		return;
	}
	
	int level;
	uint8_t unit = [[UnitHelper sharedHelper] unitOpenedAtMission:campaign.currentMission + 1 upgrade:&level];
	
	if (level > 0) {
		//костыль. после 9 миссии нужно показать 2 сообщения
		SEL afterAction = (campaign.currentMission == 8)? @selector(showAnihillatorMessage) : @selector(finishGame); 
		[RichMessageBoxController showWithHeader:@"Mission complete" andPicture:[[UnitHelper sharedHelper] getMapTextureOf:unit And:level] 
										 andText:@"On the ruins of enemy base you have found a scheme of the robot upgrade"
										 andAction:afterAction andHandler:self
		 ];
	} else {
		NSMutableString* message = [NSMutableString stringWithString:@"On the ruins of enemy base you have found a scheme of the new robot"];
		int turnsBefore = [[UnitHelper sharedHelper] getTurnsBefore:unit];
		
		if (turnsBefore > 0) {
			[message appendFormat:@". You will be able to build it after %d turns", turnsBefore];
		}
		
		[RichMessageBoxController showWithHeader:@"Mission complete" andPicture:[[UnitHelper sharedHelper] getMapTextureOf:unit And:level] 
										 andText:message
										 andAction:@selector(finishGame) andHandler:self
		 ];
	}

}

-(void)showAnihillatorMessage {
	[RichMessageBoxController showWithHeader:@"Mission complete" andPicture:[[UnitHelper sharedHelper] getMapTextureOf:MWUnitAnnihilator And:0] 
									 andText:@"Also, you have found a scheme of ultimate enemy's weapon: The Annihialtor Robot"
								   andAction:@selector(finishGame) andHandler:self
	 ];
}

-(void)finalizeMission {
	
	[[FFGame sharedGame] unregisterModel:@"player"];
	[[FFGame sharedGame] unregisterModel:@"enemy"];	
	
	[[FFGame sharedGame].timerManager removeAllTimers];
	[[FFGame sharedGame].actionManager removeAllActions];
	[[FFGame sharedGame] removeAllControllers];

	[[MapLoader sharedLoader] destroyMap];
	[[GameUI sharedUI] destroyMap];
	[[GameUI sharedUI] hideGame];
	
}

@end

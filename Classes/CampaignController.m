//
//  CampaignController.m
//  MathWars
//
//  Created by SwinX on 19.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "CampaignController.h"
#import "FFGame.h"
#import "FFButton.h" 
#import "StartMenuController.h"
#import "MissionPreloaderController.h"

@implementation CampaignController

+(CampaignController*)controller {
	return [[[CampaignController alloc] init] autorelease];
}

-(id)init {
	if (self = [super init]) {
		model = [[FFGame sharedGame] getModelByName:@"campaign"];
		view = [[CampaignView alloc] initWithCampaign:model];
		
		FFButton* button;
		
		for (int i=0; i<model.missionsOpened; i++) {
			button = [view.buttons objectAtIndex:i];
			[button.click addHandler:self andAction:@selector(missionButtonPressed:)];
		}
		
		button = [view.buttons objectAtIndex:view.buttons.count - 1];
		[button.click addHandler:self andAction:@selector(returnButtonPressed)];
		
	}
	return self;
}

-(void)returnButtonPressed {
	[[FFGame sharedGame] removeController:self];
	[[FFGame sharedGame] addController:[StartMenuController controller]];
}

-(void)missionButtonPressed:(FFButton*)button {
	[model beginMission:[button.tag intValue]];
	[[FFGame sharedGame] removeController:self];
	[[FFGame sharedGame].soundManager stopBGM];
}

-(void)addedToGame {
	[view show];
}

-(void)removedFromGame {
	[view hide];
}

-(void)dealloc {
	[view release];
	[super dealloc];
}

@end

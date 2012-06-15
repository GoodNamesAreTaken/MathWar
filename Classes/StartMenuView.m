//
//  StartMenuView.m
//  MathWars
//
//  Created by Inf on 10.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "StartMenuView.h"
#import "FFGame.h"


@implementation StartMenuView
@synthesize startSingleGame, startMultiplayer, startCampaign, tutorial;

-(id)init {
	if (self = [super init]) {
		
		back = [FFSprite spriteWithTextureNamed:@"menuBack$d.png"];
		back.layer = 0;
		startCampaign = [[FFButton alloc] initWithNormalTexture:@"campaignButtonNormal.png" pressedTexture:@"campaignButtonPressed.png" andDisabledTexture:nil andText:@"Campaign" andSound:@"menuClick"];
		startSingleGame = [[FFButton alloc] initWithNormalTexture:@"singleNormal.png" pressedTexture:@"singlePressed.png" andDisabledTexture:nil andText:@"Random Game" andSound:@"menuClick"];
		startMultiplayer = [[FFButton alloc] initWithNormalTexture:@"multiNormal.png" pressedTexture:@"multiPressed.png" andDisabledTexture:nil andText:@"Multiplayer" andSound:@"menuClick"];
		tutorial = [[FFButton alloc] initWithNormalTexture:@"tutorialNormal.png" pressedTexture:@"tutorialPressed.png" andDisabledTexture:nil andText:@"Tutorial" andSound:@"menuClick"];
		
		startCampaign.layer = startSingleGame.layer = startMultiplayer.layer = tutorial.layer = 1;
		
		[self rotated];
		
		[self addChild:back];
		[self addChild:startCampaign];
		[self addChild:startSingleGame];
		[self addChild:startMultiplayer];
		[self addChild:tutorial];
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
	}
	return self;
}

-(void)rotated {
	back.x = [FFGame sharedGame].renderer.screenWidth / 2;
	back.y = [FFGame sharedGame].renderer.screenHeight / 2;
	
	startCampaign.x = ([FFGame sharedGame].renderer.screenWidth  - startCampaign.width) * 0.5f;
	startCampaign.y = [FFGame sharedGame].renderer.screenHeight / 2 - 2.5*startCampaign.height;
	
	startSingleGame.x = ([FFGame sharedGame].renderer.screenWidth  - startSingleGame.width) * 0.5f;
	startSingleGame.y = startCampaign.y + startCampaign.height + 1;
	
	startMultiplayer.x =  ([FFGame sharedGame].renderer.screenWidth  - startMultiplayer.width) * 0.5f;
	startMultiplayer.y = startSingleGame.y + startSingleGame.height + 1;
	
	tutorial.x = ([FFGame sharedGame].renderer.screenWidth  - tutorial.width) * 0.5f;
	tutorial.y = startMultiplayer.y + startMultiplayer.height;
}

-(id)retain {
	return [super retain];
}

-(void)release {
	[super release];
}

-(void)dealloc {
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[startSingleGame release];
	[startMultiplayer release];
	[startCampaign release];
	[tutorial release];
	[super dealloc];
}

@end

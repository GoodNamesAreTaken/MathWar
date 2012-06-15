//
//  WinCampaignController.m
//  MathWars
//
//  Created by SwinX on 08.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "WinCampaignController.h"
#import "StartMenuController.h"
#import "FFGame.h"
#import "MapFinisher.h"

@implementation WinCampaignController

+(void)epicWin {
	
	FFSprite* sprite = [FFSprite spriteWithTextureNamed:@"winScreen$d.png"]; 
	sprite.layer = 1;
	
	WinCampaignController* controller = [[WinCampaignController alloc] initWithView:sprite];
	[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
	
	[[FFGame sharedGame] addController:[controller autorelease]];
	[controller rotated];
	[[FFGame sharedGame].soundManager playBackgroundMusic:@"happyEnd.caf" once:YES];
	
}

-(void)rotated {
	sprite.x = [FFGame sharedGame].renderer.screenWidth/2;
	sprite.y = [FFGame sharedGame].renderer.screenHeight/2;
}

-(void)endTouchAt:(CGPoint)point {
	if ([view pointInside:point]) {
		[[FFGame sharedGame] removeController:self];
		[[FFGame sharedGame] addController:[StartMenuController controller]];
	}
}

-(void)dealloc {
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[super dealloc];
}

@end


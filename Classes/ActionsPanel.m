//
//  ActionsPanel.m
//  MathWars
//
//  Created by Inf on 03.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFSprite.h"
#import "FFGame.h"
#import "ActionsPanel.h"

@interface ActionsPanel(Private)

-(void)showActiveIcon;
-(void)showIdleIcon;

@end


@implementation ActionsPanel
@synthesize endTurnButton, upgradeButton, surrenderButton, buildButton;

-(id)init {
	if (self = [super init]) {
		
		back = [[FFSprite spriteWithTextureNamed:@"uiBack$d.png"] retain];
		back.x = back.width * 0.5f;
		back.y = back.height * 0.5f;
		back.layer = 0;
		[self addChild:back];
		
		surrenderButton = [[FFButton alloc] initWithNormalTexture:@"surrenderNormal.png" pressedTexture:@"surrenderPressed.png" andText:@""];
		surrenderButton.layer = 1;
		surrenderButton.x = 5;
		surrenderButton.y = 5;
		
		buildButton = [[FFButton alloc] initWithNormalTexture:@"buildNormal.png" pressedTexture:@"buildPressed.png" andDisabledTexture:@"buildDisabled.png" andText:@""];
		buildButton.x = [FFGame sharedGame].renderer.screenWidth * 0.5f - buildButton.width - 2.5f;
		buildButton.y = 5;
		buildButton.layer = 1;
		buildButton.disabled = YES;
		
		upgradeButton = [[FFButton alloc] initWithNormalTexture:@"upgradeNormal.png" pressedTexture:@"upgradePressed.png" andDisabledTexture:@"upgradeDisabled.png" andText:@""];
		upgradeButton.x = [FFGame sharedGame].renderer.screenWidth * 0.5f + 2.5f;
		upgradeButton.y = 5;
		upgradeButton.layer = 1;
		upgradeButton.disabled = YES;
		
		idleIcon = [[FFSprite alloc] initWithTextureNamed:@"idleIcon.png"];
		idleIcon.x = idleIcon.width / 2;
		idleIcon.y = [FFGame sharedGame].renderer.screenHeight - idleIcon.height / 2;
		idleIcon.layer = 1;
		
		endTurnButton = [[FFBlinkingButton alloc] initWithNormalTexture:@"endTurnNormal.png" pressedTexture:@"endTurnPressed.png" andBlinkingTexture:@"endTurnBlink.png"];
		endTurnButton.layer = 1;
		endTurnButton.x = [FFGame sharedGame].renderer.screenWidth - endTurnButton.width - 5.0f;
		endTurnButton.y = 5;
		
		[self addChild:upgradeButton];
		[self addChild:buildButton];
		currentState = APStateIdle;
		
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];

		
	}
	return self;
}

-(void)rotated {
	back.x = back.width * 0.5f;
	back.y = back.height * 0.5f;
	
	idleIcon.y = [FFGame sharedGame].renderer.screenHeight - idleIcon.height / 2;
	buildButton.x = [FFGame sharedGame].renderer.screenWidth * 0.5f - buildButton.width - 2.5f;
	
	upgradeButton.x = [FFGame sharedGame].renderer.screenWidth * 0.5f + 2.5f;
	endTurnButton.x = [FFGame sharedGame].renderer.screenWidth - endTurnButton.width - 5.0f;
}



-(void)showIn:(FFGenericRenderer *)renderer {
	[super showIn:renderer];
}

-(void)showIdlePanel {
	if (currentState != APStateIdle) {
		currentState = APStateIdle;
		
		[self addChild:idleIcon];
		[self removeChild:endTurnButton];
		[self removeChild:surrenderButton];
		
		upgradeButton.disabled = YES;
		buildButton.disabled = YES;
	}
}

-(void)showActivePanel {
	if (currentState != APStateActions) {
		currentState = APStateActions;
		[self removeChild:idleIcon];
		[self addChild:endTurnButton];
		[self addChild:surrenderButton];
		
		upgradeButton.disabled = YES;
		buildButton.disabled = YES;
	}
	
}

-(void)showBuildButtons {
	upgradeButton.disabled = YES;
	buildButton.disabled = NO;
	
}

-(void)showUpgradeButton {
	upgradeButton.disabled = NO;
	buildButton.disabled = YES;
}

-(void)hideBuildButtons {
	buildButton.disabled = YES;
}

-(void)hideUpgradeButton {
	upgradeButton.disabled = YES;
}


-(void)dealloc {
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[back release];
	[surrenderButton release];
	[upgradeButton release];
	[idleIcon release];
	[endTurnButton release];
	[super dealloc];
}

@end

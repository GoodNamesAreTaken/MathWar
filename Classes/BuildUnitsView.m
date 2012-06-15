//
//  BuildPanel.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "BuildUnitsView.h"
#import "UnitHelper.h" 
#import "FFGame.h"
#import "Player.h"
#import "GameUI.h"

#define TURNS_BEFORE_CANONEER 3
#define TURNS_BEFORE_TITAN 5
#define TURNS_BEFORE_ANNIHILATOR 7


#define BORDER 0

@interface BuildUnitsView(Private)

-(void)addLockToButton:(FFButton*)button;

@end


@implementation BuildUnitsView
@synthesize buildTankButton, buildGunnerButton, buildCanoneerButton, buildTitanButton, buildAnnihilatorButton, cancelButton, endPoint;


-(id)init {
	if (self = [super init]) {
		Player* player = [[FFGame sharedGame] getModelByName:@"player"];
		
		

		buildTankButton = [[UnitHelper sharedHelper] getBuildViewOf:MWUnitTank withBack:@"buildTop$d.png" locked:![player.restrictions isUnitAvaliable:MWUnitTank]];
		buildTankButton.layer = 4;
		[self addChild:buildTankButton];
		
		buildGunnerButton = [[UnitHelper sharedHelper] getBuildViewOf:MWUnitGunner withBack:@"buildDark$d.png" locked:![player.restrictions isUnitAvaliable:MWUnitGunner]];
		buildGunnerButton.layer = 4;
		buildGunnerButton.y = buildTankButton.height;
		[self addChild:buildGunnerButton];
		
		buildCanoneerButton = [[UnitHelper sharedHelper] getBuildViewOf:MWUnitCannoneer withBack:@"buildLight$d.png" locked:![player.restrictions isUnitAvaliable:MWUnitCannoneer]];
		buildCanoneerButton.y = buildGunnerButton.y + buildGunnerButton.height;
		buildCanoneerButton.layer = 4;
		[self addChild:buildCanoneerButton];
		
		buildTitanButton = [[UnitHelper sharedHelper] getBuildViewOf:MWUnitTitan withBack:@"buildDark$d.png" locked:![player.restrictions isUnitAvaliable:MWUnitTitan]];
		buildTitanButton.y = buildCanoneerButton.y + buildCanoneerButton.height;
		buildTitanButton.layer = 4;
		[self addChild:buildTitanButton];
		
		buildAnnihilatorButton = [[UnitHelper sharedHelper] getBuildViewOf:MWUnitAnnihilator withBack:@"buildLight$d.png" locked:![player.restrictions isUnitAvaliable:MWUnitAnnihilator]];
		buildAnnihilatorButton.y = buildTitanButton.y + buildTitanButton.height;
		buildAnnihilatorButton.layer = 4;
		[self addChild:buildAnnihilatorButton];
		
		footer = [FFSprite spriteWithTextureNamed:@"buildBottom$d.png"];
		footer.x = footer.width * 0.5f;
		footer.y = footer.height * 0.5f + buildAnnihilatorButton.y + buildAnnihilatorButton.height;
		footer.layer = 4;
		[self addChild:footer];
				  
		cancelButton = [[FFButton alloc] initWithNormalTexture:@"cancelBuildNormal$d.png" pressedTexture:@"cancelBuildPressed$d.png" andDisabledTexture:nil andText:@"Cancel" andSound:@"defaultClick"];
		cancelButton.x = footer.x - cancelButton.width * 0.5f;
		cancelButton.y = footer.y - cancelButton.height * 0.5f;
		[cancelButton.text setColorR:0 G:0 B:0 A:255];
		
		cancelButton.layer = 5;
		[self addChild:cancelButton];
		
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
	}
	return self;
}

-(void)rotated {
	CGPoint end = self.endPoint;
	[self setPositionX:end.x y:end.y];
}

-(CGPoint)endPoint {
	return CGPointMake(([FFGame sharedGame].renderer.screenWidth - self.width) * 0.5f, 
					   65 + ([FFGame sharedGame].renderer.screenHeight - 65 - [GameUI sharedUI].textPanel.height - self.height) * 0.5f);
}

-(float)width {
	return buildTankButton.width;
}

-(float)height {
	return buildTankButton.height + buildGunnerButton.height + buildCanoneerButton.height + buildTitanButton.height + buildAnnihilatorButton.height + footer.height;
}

-(void)dealloc {
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[cancelButton release];
	[super dealloc];
}

@end

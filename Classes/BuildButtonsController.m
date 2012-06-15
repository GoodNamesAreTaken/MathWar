//
//  BuildPanelController.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFGame.h"
#import "Unit.h"
#import "BuildButtonsController.h"
#import "GameUI.h"


@implementation BuildButtonsController
@synthesize fallAction;

+(id)controllerWithModel:(Factory*)model {
	return [[[BuildButtonsController alloc] initWithModel:model] autorelease];
}


-(id)initWithModel:(Factory*)factoryModel {
	if (self = [super init]) {
		model = [factoryModel retain];
		view = [[BuildUnitsView alloc] init];
		fallSound = [[[FFGame sharedGame].soundManager getSound:@"buildWindow"] retain];
		
	}
	return self;
}

-(void)addedToGame {
	
	[[GameUI sharedUI].panel showBuildButtons];	
	[[GameUI sharedUI].panel.buildButton.click addHandler:self andAction:@selector(showView)];
	[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
}

-(void)removedFromGame {
	[GameUI sharedUI].lock.dialogAtScreen = NO;
	[[GameUI sharedUI].panel hideBuildButtons];
	[view hide];
}

-(void)rotated {
	[[FFGame sharedGame].actionManager cancelAction:self.fallAction];
	[self fallFinished];
}

-(void)showView {
	
	CGPoint start;
	start.x = ([FFGame sharedGame].renderer.screenWidth - view.width) * 0.5f;
	start.y = -view.height;
	[fallSound loop];
	[GameUI sharedUI].lock.dialogAtScreen = YES;
	self.fallAction = [view slideActionFrom:start To:view.endPoint withAfterSlideAction:@selector(fallFinished) ofObject:self];
	
	[view.buildTankButton.buildButton.click addHandler:self andAction:@selector(buildTank)];
	[view.buildGunnerButton.buildButton.click addHandler:self andAction:@selector(buildGunner)];
	
	if (view.buildCanoneerButton.buildButton.tag != @"locked") {
		[view.buildCanoneerButton.buildButton.click addHandler:self andAction:@selector(buildCanoneer)];
	}

	if (view.buildTitanButton.buildButton.tag != @"locked") {
		[view.buildTitanButton.buildButton.click addHandler:self andAction:@selector(buildTitan)];
	}
	
	if (view.buildAnnihilatorButton.buildButton.tag != @"locked") {
		[view.buildAnnihilatorButton.buildButton.click addHandler:self andAction:@selector(buildAnnihilator)];
	}

	[view.cancelButton.click addHandler:self andAction:@selector(cancelBuild)];
	
	[view show];
	[view setPositionX:start.x y:start.y];
	[[FFGame sharedGame].actionManager addAction:self.fallAction];
	    
}

-(void)fallFinished {
	self.fallAction = nil;
    [fallSound stop];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UnitSelectShown" object:view];
}

-(void)buildTank {
	[model buildUnitOfType:MWUnitTank];
	[[FFGame sharedGame] removeController:self];
}

-(void)buildGunner {
	[model buildUnitOfType:MWUnitGunner];
	[[FFGame sharedGame] removeController:self];
}

-(void)buildCanoneer {
	[model buildUnitOfType:MWUnitCannoneer];
	[[FFGame sharedGame] removeController:self];
}

-(void)buildTitan {
	[model buildUnitOfType:MWUnitTitan];
	[[FFGame sharedGame] removeController:self];	
}

-(void)buildAnnihilator {
	[model buildUnitOfType:MWUnitAnnihilator];
	[[FFGame sharedGame] removeController:self];
}

-(void)cancelBuild {
	[[FFGame sharedGame] removeController:self];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"BuildCanceled" object:nil];
}

-(void)dealloc {
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[fallSound release];
	[model release];
	[view release];
	[super dealloc];
}


@end

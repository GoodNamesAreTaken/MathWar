//
//  FactoryController.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFGame.h"
#import "FactoryController.h"
#import "BuildButtonsController.h"
#import "NotificationController.h"

#import "MapUnitView.h"
#import "Unit.h"
#import "BuildingView.h"
#import "GameUI.h"
#import "UnitHelper.h"
#import "MapUnitSound.h"
#import "PlaySound.h"

@implementation FactoryController

+(id)controllerWithModel:(MapObject*)model andView:(FFView*)view {
	return [[[FactoryController alloc] initWithModel:model andView:view] autorelease];
}

-(id)initWithModel:(MapObject *)factory andView:(FFView *)factoryView {
	if (self = [super initWithModel:factory andView:factoryView]) {
		((Factory*)model).delegate = self;
	}
	return self;
}

-(void)endTouchAt:(CGPoint)point {
	
	if (touchStarted) {
		[super endTouchAt:point];
		if ([view pointInside:point] && ![GameUI sharedUI].lock.isMapLocked) {
			
			if (model.guardian == nil && [self isPlayerOwnsObject] && !((Factory*)model).buildedUnitThisTurn) {
				
				[[FFGame sharedGame] addController:[BuildButtonsController controllerWithModel:(Factory*)model]];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BuildButtonShown" object:nil];
				
			} else if (model.guardian != nil && [self isPlayerOwnsObject] && !((Factory*)model).buildedUnitThisTurn && model.guardian.canBeUpgraded) {
				
				[[GameUI sharedUI].panel.upgradeButton.click addHandler:model andAction:@selector(upgradeGuardian)];
				[[GameUI sharedUI].panel showUpgradeButton];
				[[NSNotificationCenter defaultCenter] postNotificationName:@"UpgradeButtonShown" object:nil];
			}
		}
	}
}

-(void)beginTouchAt:(CGPoint)point {
	[super beginTouchAt:point];
}

-(void)buildedUnit:(Unit *)unit {
	
	MapUnitView* unitView = [[UnitHelper sharedHelper] getMapViewOf:unit.type];
	MapUnitSound* unitSound = [[[MapUnitSound alloc] initWithType:unit.type] autorelease];
	
	unitView.x = model.x;
	unitView.y = model.y;
	
	unitView.layer = 3;
	
	[unit addObserver:unitView];
	[unit addObserver:unitSound];
	[[GameUI sharedUI].mapView addChild:unitView];
	[[GameUI sharedUI].mapView scrollToX:view.absoluteX y:view.absoluteY];
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:@"buildSound"]];
}

-(void)factory:(Factory*)factory upgradedUnit:(Unit*)unit {
	[[GameUI sharedUI].mapView scrollToX:view.absoluteX y:view.absoluteY];
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:@"buildSound"]];
}

-(void)upgradeStarted {
	[[GameUI sharedUI].panel hideUpgradeButton];
	if ([GameUI sharedUI].lock.isPlayerTurn) {
		((HumanPlayer*)[[FFGame sharedGame] getModelByName:@"player"]).activeUnit = nil;
	}
}

@end

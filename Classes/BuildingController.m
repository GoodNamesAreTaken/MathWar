//
//  BildingController.m
//  MathWars
//
//  Created by Inf on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFGame.h"
#import "Building.h"
#import "BuildingView.h"
#import "BuildingController.h"


@implementation BuildingController

+(id)controllerWithModel:(MapObject*)object andView:(FFView*)view {
	return [[[BuildingController alloc] initWithModel:object andView:view] autorelease];
}

-(id)initWithModel:(MapObject *)object andView:(FFView *)buildingView {
	if (self = [super initWithModel:object andView:buildingView]) {
		((Building*)model).delegate = self;
	}
	return self;
}

-(void)ownerChangedTo:(Player *)owner {
	if (owner == nil) {
		[(BuildingView*)view becomeNeutral];
	} else if (owner == [[FFGame sharedGame] getModelByName:@"player"]) {
		[(BuildingView*)view becomePlayer];
	} else {
		[(BuildingView*)view becomeEnemy];
	}
}

-(BOOL)isPlayerOwnsObject {
	return [(Factory*)model owner] == player;
}

@end

//
//  MapObjectController.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFGame.h"
#import "MapObjectController.h"
#import "GameUI.h"


@implementation MapObjectController

+(id)controllerWithModel:(MapObject*)model andView:(FFView*)view {
	return [[[MapObjectController alloc] initWithModel:model andView:view] autorelease];
}

-(id)initWithModel:(MapObject*)object andView:(FFView*)objectView {
	if (self = [super init]) {
		model = object;
		view = [objectView retain];
		
		view.x = model.x;
		view.y = model.y;
		
		player = [[[FFGame sharedGame] getModelByName:@"player"] retain];
		
		touchStarted = NO;
	}
	return self;
}

-(void)beginTouchAt:(CGPoint)point {
	if ([view pointInside:point]) {
		touchStarted = YES;
	} else {
		touchStarted = NO;
	}	
}

-(void)endTouchAt:(CGPoint)point {
	
	if ([view pointInside:point] && ![GameUI sharedUI].lock.isMapLocked && touchStarted) {
		
		if (model.guardian != nil && [self isPlayerOwnsObject]) {
			
			if (player.activeUnit == model.guardian) {
				player.activeUnit = nil;
				[[GameUI sharedUI].textPanel showMovesCount];
				[[NSNotificationCenter defaultCenter] postNotificationName:@"UnitDeselected" object:model.guardian];
			} else {
				player.activeUnit = model.guardian;
				[[NSNotificationCenter defaultCenter] postNotificationName:@"UnitSelected" object:model.guardian];
				[[GameUI sharedUI].textPanel setMessage:[NSString stringWithFormat:@"Attack:%d Health:%d", model.guardian.attack, model.guardian.health]];
			}
			
		} else if (player.activeUnit != nil && [player.activeUnit.location.neighbours containsObject:model]) {
			[player.activeUnit tryToMoveTo:model];
			player.activeUnit = nil;
		}
		
		touchStarted = NO;
	}
}

-(BOOL)isPlayerOwnsObject {
	return model.guardian.owner == player;
}

-(void)dealloc {
	[player release];
	[view release];
	[super dealloc];
}

@end

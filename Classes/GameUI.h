//
//  GameUI.h
//  MathWars
//
//  Created by Inf on 16.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "MapView.h"
#import "MapLock.h"
#import "ActionsPanel.h"
#import "FFSprite.h"
#import "TextPanel.h"

#import "Player.h"


@interface GameUI : NSObject {
	MapView* mapView;
	MapLock* lock;
	ActionsPanel* panel;
	TextPanel* textPanel;
	NSMutableArray* lines;
}

@property(readonly) MapView* mapView;
@property(readonly) ActionsPanel* panel;
@property(readonly) MapLock* lock;
@property(readonly) TextPanel* textPanel;

+(GameUI*)sharedUI;

-(void)showGame;
-(void)hideGame;
-(void)destroyMap;
-(void)buildMapViewForPlayer:(Player*)player andEnemy:(Player*)enemy;


@end

//
//  FingerView.m
//  MathWars
//
//  Created by Inf on 10.08.10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "FingerView.h"
#import "FFGame.h"
#import "GameUI.h"
#import "MapLoader.h"
#import "FFSprite.h"

@implementation FingerView
@synthesize moveAction;

-(id)init {
	if (self = [super init]) {
		FFSprite* sprite = [FFSprite spriteWithTextureNamed:@"finger.png"];
		[self addChild:sprite];
	}
    return self;
}

-(void)moveToPoint:(CGPoint)point {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[FFGame sharedGame].actionManager cancelAction:self.moveAction];
	float speed;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		speed = 600;
	} else {
		speed = 250;
	}

    self.moveAction = [Move view:self to:point withSpeed: speed];
    [[FFGame sharedGame].actionManager addAction:self.moveAction];
}

-(void)focusOnView:(FFView*)view {
	self.layer = 200;
	[[FFGame sharedGame].renderer resort];
    [self moveToPoint:CGPointMake(view.absoluteX + view.width * 0.5f, view.absoluteY + view.width*0.5f)];
}

-(void)focusOnMapObjectById:(uint8_t)objectId {
	[self focusOnMapObject:[[MapLoader sharedLoader] getMapObjectByID:objectId]];
}

-(void)focusOnMapObject:(MapObject*)mapObject {
    focusObject = mapObject;
	self.layer = 5;
	[[FFGame sharedGame].renderer resort];
    [self moveToPoint:CGPointMake([GameUI sharedUI].mapView.absoluteX + mapObject.x, [GameUI sharedUI].mapView.absoluteY + mapObject.y)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mapMoved:) name:@"MapMoved" object:nil];
}

-(void)mapMoved:(NSNotification*)notification {
    [self focusOnMapObject:focusObject];
}

-(void)focusOnNearestUnitTo:(uint8_t)objectId {
	NSMutableArray* toLook = [NSMutableArray arrayWithObject:[[MapLoader sharedLoader] getMapObjectByID:objectId]];
	NSMutableArray* closed = [NSMutableArray array];
	
	while (toLook.count > 0) {
		MapObject* object = [toLook objectAtIndex:0];
		if (object.guardian != nil) {
			[self focusOnMapObject:object];
			return;
		}
		[toLook removeObjectAtIndex:0];
		[closed addObject:object];
		for (MapObject* neighour in object.neighbours) {
			if (![closed containsObject:neighour] && ![toLook containsObject:neighour]) {
				[toLook addObject:neighour];
			}
		}
	}
}

-(void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    self.moveAction = nil;
    [super dealloc];
}

@end

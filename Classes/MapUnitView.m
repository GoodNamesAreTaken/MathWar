//
//  MapUnitView.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "MapObject.h"
#import "MapUnitView.h"
#import "FFGame.h"
#import "GameUI.h"
#import "MoveUnit.h"
#import "Call.h"
#import "UnitHelper.h"

@interface MapUnitView(Private)
-(void)setFlagCoords;
@end

@implementation MapUnitView

-(id)initWithTextureNamed:(NSString*)name {
	
	if (self = [super init]) {
		unitImage = [[FFSprite spriteWithTextureNamed:name] retain];
		[self addChild:unitImage];
		
		pickFlag = [[ShakingView alloc] initWithDistance:10.0f];
		
		FFSprite* flagPicture = [FFSprite spriteWithTextureNamed:@"unitPickFlag.png"];
		flagPicture.layer = 1;
		[flagPicture setBackgroundColorR:14 g:113 b:202 a:255];
		[pickFlag addChild:flagPicture];
		pickFlag.layer = 1;

	}
	
	return self;
	
}

-(void)unit:(Unit*)_unit startedMovingTo:(MapObject*)location withFinishAction:(SEL)action {
	
	CGPoint point;
	
	point.x = location.x;
	point.y = location.y;
				
	[GameUI sharedUI].lock.hasMovingUnit = YES;
	
	FFActionSequence* moveSequence = [[FFActionSequence alloc] initWithActions:
						[Move unit:self to:point withSpeed:50.0f],
						[Call selector:action ofObject:_unit withParam:location],
						[Call selector:@selector(setHasMovingUnit:) ofObject:[GameUI sharedUI].lock withParam:NO],
						nil
						];
		
	[[FFGame sharedGame].actionManager addAction:[moveSequence autorelease]];
}

-(void)finishedMovingTo:(MapObject*)location {
}

-(void)unitWasSelected:(Unit*)_unit {
	if (![self hasChild:pickFlag]) {
		[self setFlagCoords];
		[self addChild:pickFlag];
	}
}

-(void)unitSelectionWasRemoved:(Unit*)_unit {
	if ([self hasChild:pickFlag]) {
		[pickFlag stop];
		[self removeChild:pickFlag];
	}
}

-(void)unitDied {
	NSLog(@"Unit view died");
	if (parent != nil) {
		NSLog(@"Remove from parent");
		[((FFCompositeView*)parent) removeChild:self];
		[self hide];
	}

}

-(void)unitUpgraded:(Unit *)_unit {
	[self setUnitImage:[[UnitHelper sharedHelper] getMapSpriteOf:_unit.type And:_unit.upgrades]];	
}

-(void)setFlagCoords {
	pickFlag.x = unitImage.x;
	pickFlag.y = -unitImage.height;
	[pickFlag shakeOnY];
}

-(void)setUnitImage:(FFSprite *)newImage {
	[self removeChild:unitImage];
	[unitImage release];
	unitImage = [newImage retain];
	[self addChild:newImage];
}

-(FFSprite*)unitImage {
	return unitImage;
}

-(void)dealloc {
	[unitImage release];
	[pickFlag release];
	[super dealloc];
}

@end

//
//  MapUnitSound.m
//  MathWars
//
//  Created by Inf on 01.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MapUnitSound.h"
#import "FFGame.h"
#import "UnitHelper.h"

@implementation MapUnitSound

-(id)initWithType:(uint8_t)type {
	if (self = [super init]) {
		moveSound = [[[FFGame sharedGame].soundManager getSound:[[UnitHelper sharedHelper] getMoveSoundOf:type]] retain];
		pickSound = [[[FFGame sharedGame].soundManager getSound:@"unitPick"] retain];
	}
	return self;
}

-(void)unit:(Unit *)_unit startedMovingTo:(MapObject *)location withFinishAction:(SEL)action {
	[moveSound loop];
}

-(void)unit:(Unit *)_unit finishedMovingTo:(MapObject *)location {
	[moveSound stop];
}

-(void)unitWasSelected:(Unit *)_unit {
	[pickSound play];
}

-(void)unitSelectionWasRemoved:(Unit *)_unit {
	[pickSound stop];
}

-(void)dealloc {
	[moveSound release];
	[pickSound release];
	[super dealloc];
}

@end

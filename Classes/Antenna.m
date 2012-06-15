//
//  CoalWarehouse.m
//  MathWars
//
//  Created by Inf on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Antenna.h"


@implementation Antenna

-(void)onOwnerChange:(Player *)newOwner {
	[owner showNotification:@"-1 move"];
	[owner removeObserver:self];
	[newOwner addObserver:self];
	newOwner.moveCount++;
	[newOwner showNotification:@"+1 move"];
}

-(void)playerStartedTurn:(Player *)player {
	player.moveCount++;
}

@end

//
//  Building.m
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Building.h"


@implementation Building
@synthesize owner, delegate;

-(void)setGuardian:(Unit *)newGuardian {
	if (newGuardian != nil) {
		self.owner = newGuardian.owner;
	}
	[super setGuardian:newGuardian];
}

-(void)setOwner:(Player *)_value {
	if (owner != _value) {
		[delegate ownerChangedTo:_value];
		[self onOwnerChange:_value];
		owner = _value;
	}
}

-(void)onOwnerChange:(Player*)newOwner {
	
}

-(BOOL)isNeutral {
	return owner == nil;
}

-(BOOL)belongsTo:(Player *)player {
	return owner == player;
}

@end

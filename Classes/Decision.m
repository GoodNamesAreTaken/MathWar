//
//  Descision.m
//  MathWars
//
//  Created by SwinX on 01.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Decision.h"


@implementation Decision
@synthesize decisive;

-(id)initWithPlayer:(AIPlayer*) player {
	
	if (self = [super init]) {
		self.decisive = player;
	}
	
	return self;
	
}

-(void)performDecision {	
}

-(void)dealloc {
	self.decisive = nil;
	[super dealloc];
}

@end

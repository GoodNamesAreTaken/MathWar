//
//  EndTurnDecision.m
//  MathWars
//
//  Created by SwinX on 02.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "EndTurnDecision.h"


@implementation EndTurnDecision

+(EndTurnDecision*)ofPlayer:(AIPlayer*)player {
	return [[[EndTurnDecision alloc] initWithPlayer:player] autorelease];
}

-(void)performDecision {
	[decisive endTurn];
}

@end

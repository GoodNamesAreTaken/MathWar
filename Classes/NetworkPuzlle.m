//
//  NetworkPuzlle.m
//  MathWars
//
//  Created by Inf on 12.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "NetworkPuzlle.h"


@implementation NetworkPuzlle

+(id)networkPuzzleWithDelegate:(id<PuzzleObserver>)delegate andConnection:(GameKitConnection*)connection {
	return [[NetworkPuzlle alloc] initWithDelegate:delegate andConnection:connection];
}

-(id)initWithDelegate:(id<PuzzleObserver>)delegate andConnection:(GameKitConnection*)puzzleConnection {
	if (self = [super initWithDelegate:delegate andDifficulty:0]) {
		connection = [puzzleConnection retain];
		oldDelegate = connection.messageDelegate;
		
		connection.messageDelegate = self;
	}
	return self;
}

-(void)recievePuzzleSuccessNotification {
	connection.messageDelegate = oldDelegate;
	[super success];
}

-(void)recievePuzzleFailNotification {
	connection.messageDelegate = oldDelegate;
	[super fail];
}


///Fail и Success пазла принимается только удаленно. Принудительно завршить удаленный паззл невозможно
-(void)success {
	
}

-(void)fail {
	
}

-(int)difficulty {
	return 1;
}

-(void)dealloc {
	[connection release];
	[super dealloc];
}

@end

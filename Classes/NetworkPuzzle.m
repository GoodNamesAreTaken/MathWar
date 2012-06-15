//
//  NetworkPuzlle.m
//  MathWars
//
//  Created by Inf on 12.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "NetworkPuzzle.h"


@implementation NetworkPuzzle

+(id)networkPuzzleWithDelegate:(id<PuzzleObserver>)delegate andConnection:(GameKitConnection*)connection {
	return [[[NetworkPuzzle alloc] initWithDelegate:delegate andConnection:connection] autorelease];
}

-(id)initWithDelegate:(id<PuzzleObserver>)delegate andConnection:(GameKitConnection*)puzzleConnection {
	return [super initWithDelegate:delegate andDifficulty:0];
}

-(void)recievePuzzleSuccessNotification {
	NSLog(@"Puzzle success notification");
	[super success];
}

-(void)recievePuzzleFailNotification {
	NSLog(@"Puzzle fail notification");
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

@end

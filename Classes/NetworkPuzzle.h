//
//  NetworkPuzlle.h
//  MathWars
//
//  Created by Inf on 12.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "GameKitConnection.h"
#import "Puzzle.h"


@interface NetworkPuzzle : Puzzle<MessageDelegate> {
}

+(id)networkPuzzleWithDelegate:(id<PuzzleObserver>)delegate andConnection:(GameKitConnection*)connection;
-(id)initWithDelegate:(id<PuzzleObserver>)delegate andConnection:(GameKitConnection*)connection;

@end

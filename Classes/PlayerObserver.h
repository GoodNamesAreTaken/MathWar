//
//  PlayerEventListener.h
//  MathWars
//
//  Created by Inf on 12.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Unit.h"
#import "Puzzle.h"
#import "Combat.h"


@class Player;
@class Factory;

@protocol PlayerObserver<NSObject>

@optional

-(void)player:(Player*)player assignedUnit:(Unit*)unit;

-(void)player:(Player*)player assignedFactory:(Factory*)factory;
-(void)player:(Player*)player unassignedFactory:(Factory*)factory;
-(void)playerStartedTurn:(Player*)player;
-(void)playerFinishedTurn:(Player*)player;
-(void)playerLostTheGame:(Player*)player;

-(void)player:(Player*)player createdPuzzle:(Puzzle*)puzzle;
-(void)player:(Player*)player startedCombat:(Combat*)combat;
-(void)playerSurrendered:(Player*)player;
-(void)playerChangedMoveCount:(Player*)player;

-(void)player:(Player*)player hasBecomeReadyToNextRoundOfCombat:(Combat*)combat;

-(void)player:(Player*)player recievedNotification:(NSString*)notification;

@end

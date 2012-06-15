//
//  Tutorial.h
//  MathWars
//
//  Created by Inf on 28.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Player.h"
#import "Factory.h"
#import "Sheild.h"
#import "Swamp.h"
#import "FingerView.h"

typedef enum _TutorialState  {
	TSBegin,
	TSWelcome,
	TSBuild,
	TSRebuild, 
	TSMove,
	TSUpgrade,
	TSSheild,
	TSSwamp,
	TSBattle,
	TSNewUnit,
	TSNewBattle,
	
	TSTotal
}TutorialState;

@interface Tutorial : NSObject<PlayerObserver, UnitObserver> {
	TutorialState state;
    FingerView* finger;
	BOOL endTurnMessageWasShown;
	
	SEL stateCallbacks[TSTotal];
}

@property TutorialState state;

-(void)showMoveTo:(uint8_t)objectId;
-(BOOL)isUnit:(Unit*)unit nearestToObject:(uint8_t)objectId;
-(void)showEndTurn;
-(void)stateActions;
@end

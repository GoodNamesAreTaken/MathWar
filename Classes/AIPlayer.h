//
//  AIPlayer.h
//  MathWars
//
//  Created by Inf on 03.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Player.h"
#import "ImeddiateAnswerStrategy.h"
#import "DelayedAnswerStrategy.h"
#import "Decision.h"

@class Decision;

/**
 Игрок, управлемый AI
 */
@interface AIPlayer : Player {
	NSMutableArray* factories;
	
	BOOL inCombat;
	BOOL isOurTurn;
	
	id<PuzzleAnswerStrategy> answerStrategy;
	ImeddiateAnswerStrategy* immediateAnswerStrategy;
	DelayedAnswerStrategy* delayedAnswerStrategy;
	
	Decision* decision;
}

@property(retain) Decision* decision;

-(void)newDecision;
-(void)tryToUpdgrade;
-(void)combatExited;

@end

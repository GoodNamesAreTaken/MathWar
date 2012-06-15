//
//  HumanPuzzleController.m
//  MathWars
//
//  Created by SwinX on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "PuzzleController.h"
#import "FFGame.h"
#import "PlaySound.h" 
#import "StatisticManager.h"
#import "GameUI.h"

@implementation PuzzleController
@synthesize model, view, state, slideAction;

-(id)initWithPuzzle:(HumanPuzzle*)puzzle andView:(PuzzleView*)puzzleView {
	
	if (self = [super init]) {

		model = [puzzle retain];
		view = [puzzleView retain];
		
		[view setDescription:model.description];
		
		[view.finished addHandler:self andAction:@selector(remove)];
		
		[model addObserver:view];
		
		remainingTime = model.difficulty * 3; 
		[view setRemainigTime:remainingTime];
		
		fallSound = [[[FFGame sharedGame].soundManager getSound:@"buildWindow"] retain];
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
		
	}	
	return self;
}

-(void)addedToGame {
	
	puzzleTime = CFAbsoluteTimeGetCurrent();
	[state appear:self];
	[fallSound loop];
	CGPoint start;
	start.x = ([FFGame sharedGame].renderer.screenWidth - view.width) * 0.5f;
	start.y = [FFGame sharedGame].renderer.screenHeight;
	
	[view setPositionX:start.x y:start.y];
	[view show];
	self.slideAction = [view slideActionFrom:start To:view.endPoint withAfterSlideAction:@selector(startTimer) ofObject:self];
	[[FFGame sharedGame].actionManager addAction:self.slideAction];
	
}

-(void)rotated {
	if (!timer) {
		[[FFGame sharedGame].actionManager cancelAction:self.slideAction];
		[self startTimer];
	}
}

-(void)removedFromGame {
	[timer stop];
	[timer release];
	timer = nil;
	[view hide];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"PuzzleFinished" object:self];
}

-(void)beginTouchAt:(CGPoint)point {
	if ([view pointInside:point] && model.answered && [state respondsToSelector:@selector(forceDisapear:)]) {
		[state forceDisapear:self];
	}
}

-(void)startTimer {
	self.slideAction = nil;
	[fallSound stop];
	[view showButtons];
	[self addActionsToButtons];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PuzzleStarted" object:self];
    
	timer = [[[FFGame sharedGame].timerManager getTimerWithInterval:1.0f andSingleUse:NO] retain];
	[timer.action addHandler:self andAction:@selector(secondElapsed)];
}

-(void)secondElapsed {
	
	remainingTime--;
	
	[view setRemainigTime:remainingTime];
		
	if (remainingTime == 0) {
		[model fail];
		[timer stop];
	}	
	
}

-(void)remove {
	
	if (model.solved) {
		puzzleTime = CFAbsoluteTimeGetCurrent() - puzzleTime;
		[[StatisticManager manager] addAnswerTime:puzzleTime/model.difficulty];
	}
	
	if (timer) {
		[timer stop];
		[timer release];
		timer = nil;
	}
	
	[state disapear:self];
}

-(void)addActionsToButtons {	
}


-(void)dealloc {
	self.slideAction = nil;
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	self.state = nil;
	[fallSound release];
	[timer release];
	[model release];
	[view release];
	[super dealloc];
	
}

@end

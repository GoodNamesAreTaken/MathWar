//
//  ActionManager.h
//  MathWars
//
//  Created by Inf on 23.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "FFAction.h"

@protocol FFActionsDelegate

-(void)allActionsFinished;

@end

@interface FFActionManager : NSObject {
	NSMutableArray* actions;
	id<FFActionsDelegate> delegate;
}
@property(assign) id<FFActionsDelegate> delegate;

-(void)doActions:(CFTimeInterval)elapsedTime;

-(void)addAction:(id<FFAction>) action;

-(void)cancelAction:(id<FFAction>) action;

-(void)removeAllActions;

@end

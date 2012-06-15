//
//  Action.h
//  MathWars
//
//  Created by Inf on 23.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//



@protocol FFAction<NSObject>
@property(readonly) BOOL finished;

-(void)doForTime:(CFTimeInterval)time;
-(void)start;

@end

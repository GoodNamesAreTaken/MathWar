//
//  FactoryState.h
//  MathWars
//
//  Created by Inf on 30.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//


@class Factory;
@protocol FactoryState<NSObject>
@property(assign) Factory* factory;

-(void)doTask;

@end

//
//  HighLevelTask.h
//  MathWars
//
//  Created by Inf on 06.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Unit.h"
#import "Decision.h"

@protocol HighLevelTask<NSObject, NSCopying>
@property(assign) id performer;
@property(readonly) float cost;
@property(readonly) BOOL completed;
@property(readonly) BOOL possible;

-(Decision*)makeDecision;
-(id)copy;

@end

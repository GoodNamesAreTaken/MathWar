//
//  FFParallelActions.h
//  MathWars
//
//  Created by Inf on 31.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFAction.h"


@interface FFParallelActions : NSObject<FFAction> {

	NSMutableArray* sequence;
}
	
-(id)initWithActions:(id<FFAction>)first, ...;
	
-(void)add:(id<FFAction>)action;

@end
	

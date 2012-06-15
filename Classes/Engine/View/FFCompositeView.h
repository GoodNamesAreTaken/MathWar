//
//  CompositeView.h
//  MathWars
//
//  Created by Inf on 22.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFView.h"


@interface FFCompositeView : FFView {
	NSMutableArray* children;
	BOOL showing;
}

-(void)addChild:(FFView*)child;
-(void)removeChild:(FFView*)child;
-(BOOL)hasChild:(FFView*)child;

@end

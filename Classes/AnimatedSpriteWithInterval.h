//
//  DelayedAnimatedSprite.h
//  MathWars
//
//  Created by SwinX on 08.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFAnimatedSprite.h"


@interface AnimatedSpriteWithInterval : FFAnimatedSprite {
	float interval;
	FFTimer* intervalTimer;
}

-(id)initWithFrameNames:(NSArray*)names;

@end

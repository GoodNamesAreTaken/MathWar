//
//  SwampView.m
//  MathWars
//
//  Created by SwinX on 11.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "SwampView.h"
#import "Game.h"


@implementation SwampView

-(id)init {
	
	if (self = [super init]) {
		self.texture = [[Game sharedGame].renderer loadTexture:@"swamp.png"];
	}
	return self;
}

@end

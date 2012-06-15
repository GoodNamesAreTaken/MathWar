//
//  ObstacleView.m
//  MathWars
//
//  Created by SwinX on 09.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MineFieldView.h"
#import "Game.h"

@implementation MineFieldView

-(id)init {

	if (self = [super init]) {
		self.texture = [[Game sharedGame].renderer loadTexture:@"MineField.png"];
	}
	return self;
}

@end

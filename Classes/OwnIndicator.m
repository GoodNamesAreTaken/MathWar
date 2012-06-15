//
//  OwnIndicator.m
//  MathWars
//
//  Created by SwinX on 01.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "OwnIndicator.h"

#define ENEMY_INDICATOR @"enemyIndicator.png"
#define OUR_INDICATOR @"ourIndicator.png"


@implementation OwnIndicator

-(id)initWithNeutralTexture:(NSString*)neutralTexture{
	
	if (self = [super init]) {
		neutralSprite = [[FFSprite spriteWithTextureNamed:neutralTexture] retain];
		ourSprite = [[FFSprite spriteWithTextureNamed:OUR_INDICATOR] retain];
		enemySprite = [[FFSprite spriteWithTextureNamed:ENEMY_INDICATOR] retain];
		
		neutralSprite.layer = 0;
		ourSprite.layer = 1;
		enemySprite.layer = 1;
		
		neutralSprite.x = ourSprite.x = enemySprite.x = 0.0f;
		neutralSprite.y = ourSprite.y = enemySprite.y = 0.0f;
		
		[self addChild:neutralSprite];
		
	}
	return self;	
}

-(void)becomeNeutral {
	if ([self hasChild:ourSprite]) {
		[self removeChild:ourSprite];
	}
	
	if ([self hasChild:enemySprite]) {
		[self removeChild:enemySprite];
	}
}

-(void)becomeOur {
	
	if ([self hasChild:enemySprite]) {
		[self removeChild:enemySprite];
	}
	
	if (![self hasChild:ourSprite]) {
		[self addChild:ourSprite];
	}
}

-(void)becomeEnemy {
	if ([self hasChild:ourSprite]) {
		[self removeChild:ourSprite];
	}
	
	if (![self hasChild:enemySprite]) {
		[self addChild:enemySprite];
	}
}

-(void)dealloc {
	[neutralSprite release];
	[ourSprite release];
	[enemySprite release];
	[super dealloc];
}

@end

//
//  CombatUnitView.m
//  MathWars
//
//  Created by SwinX on 02.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "CombatUnitView.h"
#import "FFGame.h"
#import "Unit.h"
#import "Play.h"
#import "Call.h"

@implementation CombatUnitView

-(id)initWithSpritesDictionary:(NSDictionary*)dictionary { 
	
	if (self = [super init]) {
		spriteArrays = [dictionary retain];
		[self idle];
	}
	
	return self;
}

-(id<FFAction>)attack {
	
	[self pause];
	
	return [[[FFActionSequence alloc] initWithActions:
			 [Call selector:@selector(pause) ofObject:self],
			 [Play frames:[spriteArrays objectForKey:@"attack"] ofSprite:self withDelay:0.1f],
			 [Call selector:@selector(idle) ofObject:self], 
			 nil] autorelease];
}

-(id<FFAction>)receiveDamage {

	return [[[FFActionSequence alloc] initWithActions:
												[Call selector:@selector(pause) ofObject:self],
												[Play frames:[spriteArrays objectForKey:@"damage"] ofSprite:self withDelay:0.1f],
												[Call selector:@selector(idle) ofObject:self], 
												nil] autorelease];
	
}

-(id<FFAction>)die {	
	return [[[FFActionSequence alloc] initWithActions:
			 [Call selector:@selector(pause) ofObject:self],
			 [Play frames:[spriteArrays objectForKey:@"death"] ofSprite:self withDelay:0.1f],
			 nil] autorelease];
}

-(void)idle {
	[self addSpritesFromArray:[spriteArrays objectForKey:@"idle"]];
	[self playFramesFrom:0 to:self.lastFrame withDelay:0.5f];
}

-(void) dealloc {
	[unitActions release];
	[spriteArrays release];
	[super dealloc];	
}

@end

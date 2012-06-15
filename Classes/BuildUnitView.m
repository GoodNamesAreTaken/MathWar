//
//  BuildUnitView.m
//  MathWars
//
//  Created by SwinX on 28.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "BuildUnitView.h"
#import "FFGame.h"

@interface BuildUnitView(Private)

-(void)addLockToButton;

@end


@implementation BuildUnitView

@synthesize buildButton;

-(id)initWithButtonNormalTexture:(NSString*)normal buttonPressedTexture:(NSString*)pressed backTexture:(NSString*)backName attack:(int)_attack andHealth:(int)_health locked:(BOOL)_locked {
	
	if (self = [super init]) {
		back = [[FFSprite spriteWithTextureNamed:backName] retain];
		back.x = back.width * 0.5f;
		back.y = back.height * 0.5f;
		
		[self addChild:back];
		buildButton = [[FFButton alloc] initWithNormalTexture:normal pressedTexture:pressed andText:@""];
		buildButton.layer = 1;
		buildButton.x = 15;
		buildButton.y = back.height - buildButton.height;
		[self addChild:buildButton];
		
		attack = [[FFText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont:@"captions"]];
		attack.label =  [NSString stringWithFormat:@"Attack: %d", _attack];
		attack.x = back.width/3;
		attack.y = 5;
		attack.layer = 1;
		[attack setColorR:0 G:0 B:0 A:255];
		
		health = [[FFText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont:@"captions"]];
		health.label =  [NSString stringWithFormat:@"Health: %d", _health];
		health.x = back.width/3;
		health.y = back.height - health.height - 5;
		health.layer = 1;
		[health setColorR:0 G:0 B:0 A:255];
		
		locked = [[FFText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont:@"captions"]];
		locked.label = @"N/A";
		locked.x = back.width/3;
		locked.y = (back.height - locked.height) * 0.5f;
		locked.layer = 1;
		[locked setColorR:0 G:0 B:0 A:255];
		
		if (_locked) {
			[self addLockToButton];
			[self addChild:locked];
		} else {
			[self addChild:attack];
			[self addChild:health];
		}
		
	}
	return self;
}

-(float)width {
    return back.width;
}

-(float)height {
    return back.height;
}

-(void)addLockToButton {
	
	FFSprite* lock = [FFSprite spriteWithTextureNamed:@"unitLock.png"];
	lock.x = buildButton.x + lock.width / 2;
	lock.y = buildButton.y + lock.height / 2;
	lock.layer = buildButton.layer + 1;
	buildButton.tag = @"locked";
	[self addChild:lock];
	
}

-(void)dealloc {
	[buildButton release];
	[attack release];
	[health release];
	[locked release];
	[back release];
	[super dealloc];
}

////////////////iPhone//////////////////

////////////////////////////////////////



@end

//
//  TextPanel.m
//  MathWars
//
//  Created by Inf on 16.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "TextPanel.h"
#import "FFSprite.h"
#import "FFGame.h"
#import "Player.h"

@implementation TextPanel

-(id)init {
	if (self = [super init]) {
		back = [[FFSprite spriteWithTextureNamed:@"textPanel$w.png"] retain];
		back.x = back.width * 0.5f;
		back.y = back.height * 0.5f;
		back.layer = 0;
		
		[self addChild:back];
		
		self.y = [FFGame sharedGame].renderer.screenHeight - back.height;
		
		message = [[FFText alloc] initWithFontNamed:@"text"];
		message.layer = 1;
		message.y = 20.0f;
		[message setColorR:0 G:0 B:0 A:255];
		[self addChild:message];
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
	}
	return self;
}

-(void)rotated {
	back.texture = [[FFGame sharedGame].renderer loadTexture:@"textPanel$w.png"];
	back.x = back.width * 0.5f;
	back.y = back.height * 0.5f;
	self.y = [FFGame sharedGame].renderer.screenHeight - back.height;
	message.x = (back.width - message.width) * 0.5f;
}

-(void)setMessage:(NSString *)messageText {
	message.label = messageText;
	message.x = (back.width - message.width) * 0.5f;
}

-(void)showMovesCount {
	[self setMessage:[NSString stringWithFormat:@"Moves: %d",((Player*)[[FFGame sharedGame] getModelByName:@"player"]).moveCount]];
}

-(float)width {
	return back.width;
}

-(float)height {
	return back.height;
}

-(void)dealloc {
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[back release];
	[message release];
	[super dealloc];
}
@end

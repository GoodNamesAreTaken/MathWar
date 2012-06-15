//
//  FFBlinkingButton.m
//  MathWars
//
//  Created by Inf on 09.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFBlinkingButton.h"
#import "FFGame.h"

@interface FFBlinkingButton(Private)

-(void)blink;

@end



@implementation FFBlinkingButton
-(id)initWithNormalTexture:(NSString *)textureName pressedTexture:(NSString *)pressedTextureName andBlinkingTexture:(NSString*)blinkingTextureName {
	if (self = [super initWithNormalTexture:textureName pressedTexture:pressedTextureName andText:@""]) {
		blinkTextures[0] = normalTexture;
		blinkTextures[1] = [[[FFGame sharedGame].renderer loadTexture:blinkingTextureName] retain];
		textureIndex = 0;
	}
	return self;
}

-(void)startBlinking {
	blinkTimer = [[[FFGame sharedGame].timerManager getTimerWithInterval:0.5f andSingleUse:NO] retain];
	[blinkTimer.action addHandler:self andAction:@selector(blink)];
}

-(void)stopBlinking {
	[blinkTimer stop];
	[blinkTimer release];
	blinkTimer = nil;
	if (textureIndex == 1) {
		[self blink];
	}
}

-(void)blink {
	textureIndex = (textureIndex + 1) % 2;
	if (buttonImage.texture == normalTexture) {
		buttonImage.texture = blinkTextures[textureIndex];
	} 
	normalTexture = blinkTextures[textureIndex];
}

-(void)dealloc {
	[blinkTimer stop];
	[blinkTimer release];
	[blinkTextures[1] release];
	[super dealloc];
}
@end

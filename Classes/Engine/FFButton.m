//
//  Button.m
//  SimpleRPG
//
//  Created by Александр on 25.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFButton.h"
#import "FFGame.h"
#import "PlaySound.h"

@implementation FFButton

@synthesize click;
@synthesize text;
@synthesize tag;

-(id)initWithText:(NSString *)_text {
	return [self initWithNormalTexture:@"buttonNormal.png" pressedTexture:@"buttonPressed.png" andText:_text];
}

-(id)initWithNormalTexture:(NSString*)textureName pressedTexture:(NSString*)pressedTextureName andText:(NSString*)_text {
	return [self initWithNormalTexture:textureName pressedTexture:pressedTextureName andDisabledTexture:nil andText:_text];
}

-(id)initWithNormalTexture:(NSString *)textureName pressedTexture:(NSString *)pressedTextureName andDisabledTexture:(NSString *)disabledTextureName andText:(NSString *)_text {
	return [self initWithNormalTexture:textureName pressedTexture:pressedTextureName andDisabledTexture:disabledTextureName andText:_text andSound:@"defaultClick"];
}


-(id)initWithNormalTexture:(NSString*)textureName pressedTexture:(NSString*)pressedTextureName andDisabledTexture:(NSString*)disabledTextureName andText:(NSString*)_text andSound:(NSString*)soundName {
	
	if (self = [super init]) {
		
		click = [[FFEvent event] retain];
		
		normalTexture = [[[FFGame sharedGame].renderer loadTexture:textureName] retain];
		pressedTexture = [[[FFGame sharedGame].renderer loadTexture:pressedTextureName] retain];
		
		if (disabledTextureName) {
			disabledTexture = [[[FFGame sharedGame].renderer loadTexture:disabledTextureName] retain];
		}
		
		clickSound = [soundName retain];
		
		buttonImage = [[FFSprite spriteWithTexture:normalTexture] retain];
		buttonImage.x = buttonImage.width * 0.5f;
		buttonImage.y = buttonImage.height * 0.5f;

		
		text = [[FFText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont:@"captions"]];
		text.label = _text;
		text.layer = 1;
		text.x = (buttonImage.width - text.width) * 0.5f;
		text.y = (buttonImage.height - text.height) * 0.5f;
		
		[self addChild:buttonImage];
		[self addChild:text];
		
	}
	
	return self;
}

-(void)clickBegan {
	
	buttonImage.texture = pressedTexture;
	
}

-(void)clickEnded {
	
	buttonImage.texture = normalTexture;
	
	[[FFGame sharedGame].actionManager addAction:[PlaySound named:clickSound]];
	[click triggerBy:self];
	
}

-(void)resetControlState {
	if (self.disabled && disabledTexture) {
		buttonImage.texture = disabledTexture;
	} else {
		buttonImage.texture = normalTexture;
	}
}

-(float)width {

	return buttonImage.width;
	
}

-(float)height {

	return buttonImage.height;
	
}

-(void)setDisabled:(BOOL)_value {
	[super setDisabled:_value];
	
	if (self.disabled && disabledTexture) {
		buttonImage.texture = disabledTexture;
	} else {
		buttonImage.texture = normalTexture;
	}

}

-(void)dealloc {
	self.tag = nil;
	self.text = nil;
	
	[buttonImage release];
	[normalTexture release];
	[pressedTexture release];
	[disabledTexture release];
	[click release];
	[clickSound release];
	[super dealloc];
	
}

@end

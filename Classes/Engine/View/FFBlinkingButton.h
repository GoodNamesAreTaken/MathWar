//
//  FFBlinkingButton.h
//  MathWars
//
//  Created by Inf on 09.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFButton.h"
#import "FFTimer.h"

@interface FFBlinkingButton : FFButton {
	FFTexture* blinkTextures[2];
	FFTimer* blinkTimer;
	int textureIndex;
}

-(id)initWithNormalTexture:(NSString *)textureName pressedTexture:(NSString *)pressedTextureName andBlinkingTexture:(NSString*)blinkingTextureName;
-(void)startBlinking;
-(void)stopBlinking;

@end

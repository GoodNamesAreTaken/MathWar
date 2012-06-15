//
//  Button.h
//  SimpleRPG
//
//  Created by Александр on 25.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFControl.h"
#import "FFSprite.h"
#import "FFText.h"
#import "FFEvent.h"
#import "FFSound.h"


@interface FFButton : FFControl {

	FFSprite* buttonImage;
	FFText* text;
	
	FFEvent* click;
	FFTexture* normalTexture;
	FFTexture* pressedTexture;
	FFTexture* disabledTexture;
	
	NSString* clickSound;
	NSString* tag;
}

@property(readonly) float width;
@property(readonly) float height;

@property(readonly) FFEvent* click;

@property(retain) FFText* text;

@property(retain) NSString* tag;

-(id)initWithText:(NSString*)text;
-(id)initWithNormalTexture:(NSString*)textureName pressedTexture:(NSString*)pressedTextureName andText:(NSString*)_text;
-(id)initWithNormalTexture:(NSString*)textureName pressedTexture:(NSString*)pressedTextureName andDisabledTexture:(NSString*)disabledTextureName andText:(NSString*)_text;
-(id)initWithNormalTexture:(NSString*)textureName pressedTexture:(NSString*)pressedTextureName andDisabledTexture:(NSString*)disabledTextureName andText:(NSString*)_text andSound:(NSString*)soundName;


@end

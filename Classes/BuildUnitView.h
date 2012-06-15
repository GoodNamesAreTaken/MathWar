//
//  BuildUnitView.h
//  MathWars
//
//  Created by SwinX on 28.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFText.h"
#import "FFButton.h"
#import "FFSprite.h"

@interface BuildUnitView : FFCompositeView {
	FFButton* buildButton;
	FFSprite* back;
	FFText* attack;
	FFText* health;
	FFText* locked;
}

@property(readonly) FFButton* buildButton;

-(id)initWithButtonNormalTexture:(NSString*)normal buttonPressedTexture:(NSString*)pressed backTexture:(NSString*)back attack:(int)_attack andHealth:(int)_health locked:(BOOL)_locked;

@end

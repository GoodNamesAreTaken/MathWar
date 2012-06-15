//
//  TutorialWindowView.h
//  MathWars
//
//  Created by SwinX on 01.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFMultiLineText.h"
#import "FFSprite.h"
#import "FFMultiLineText.h"
#import "FFButton.h"

@interface RichMessageBoxView : FFCompositeView {
	
	FFSprite* back;
	FFText* header;
	FFSprite* picture;
	FFMultiLineText* text;
	FFButton* button;
	
}

@property(readonly) FFButton* button;

-(id)initWithPicture:(NSString*)_pic andHeader:(NSString*)_header andText:(NSString*)_text;


@end

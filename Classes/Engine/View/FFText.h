//
//  BatchText.h
//  SimpleRPG
//
//  Created by Inf on 17.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFView.h"
#import "FFFont.h"
#include "FFCBatchNode.h"

@interface FFText : FFView {
	FFCBatchNode node;
	FFFont* font;
	NSString* label;
	Color color;
}

@property(nonatomic, retain) NSString* label;

@property(nonatomic, readonly) float width;

@property(nonatomic, readonly) float height;

+(id)textWithFont:(FFFont*)font;

+(id)textWithFontNamed:(NSString*) fontName;

-(id)initWithFont:(FFFont*)textFont;

-(id)initWithFontNamed:(NSString*) fontName;

- (void) setColorR:(uint8_t)r G:(uint8_t)g B:(uint8_t)b A:(uint8_t)a;




@end

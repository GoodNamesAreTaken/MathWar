//
//  MultiLineText.h
//  SimpleRPG
//
//  Created by Inf on 12.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFText.h"


@interface FFMultiLineText : FFCompositeView {
	NSMutableArray* lines;
	FFFont* font;
	float width;
	float height;
}

-(id)initWithFont:(FFFont*)font blockWidth:(float)blockWidth blockHeight:(float)blockHeight;
-(void)addLine:(NSString*)line;

@end

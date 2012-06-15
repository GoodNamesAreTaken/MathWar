//
//  FontManager.h
//  Rocket
//
//  Created by Inf on 12.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import "FFFont.h"
#import "FFTextureStorage.h"

@interface FFFontManager : NSObject {
	NSMutableDictionary* fonts;
}

-(id) init;
-(void) loadFont:(NSString*)fontName usingTextureManager:(FFTextureStorage*)textureManager;
-(FFFont*) getFontByName:(NSString*)name usingTextureManager:(FFTextureStorage*)textureManager;

@end

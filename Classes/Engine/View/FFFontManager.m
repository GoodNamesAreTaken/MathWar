//
//  FontManager.m
//  Rocket
//
//  Created by Inf on 12.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "FFFontManager.h"


@implementation FFFontManager

-(id)init {
	if ([super init]) {
		fonts = [[NSMutableDictionary alloc] init];
	}
	return self;
}

-(void) loadFont:(NSString*)fontName usingTextureManager:(FFTextureStorage*)textureManager {
	NSString* fontTexture = [fontName stringByAppendingString: @".png"];
	FFFont* newFont = [[FFFont alloc] initWithTexture:[textureManager getAtlas:fontTexture] fontName:fontName];
	
	[fonts setObject:[newFont autorelease] forKey:fontName];
}

-(FFFont*) getFontByName:(NSString*)name usingTextureManager:(FFTextureStorage*)textureManager {
	if ([fonts objectForKey:name] == nil) {
		[self loadFont:name usingTextureManager:textureManager];
	}
	return [fonts objectForKey:name];
	
}

-(void)dealloc {
	[fonts release];
	[super dealloc];
}

@end

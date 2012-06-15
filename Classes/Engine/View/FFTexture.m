//
//  Texture.m
//  Rocket
//
//  Created by Inf on 06.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Structs.h"
#import "FFTextureAtlas.h"
#import "FFTexture.h"


@implementation FFTexture
@synthesize name=textureName, width, height, selfRelease;

+(id)textureWithName:(GLuint)name width:(float)width height:(float)height top:(float)topTexCoord left:(float)leftTexCoord bottom:(float)bottomTexCoord right:(float)rightTexCoord {
	return [[[FFTexture alloc] initWithName:name width:width height:height top:topTexCoord left:leftTexCoord bottom:bottomTexCoord right:rightTexCoord] autorelease];
}

-(id)init {
	[self release];
	return nil;
}

-(id)initWithName:(GLuint)name width:(float)texWidth height:(float)texHeight top:(float)topTexCoord left:(float)leftTexCoord bottom:(float)bottomTexCoord right:(float)rightTexCoord {
	if (self = [super init]) {
		textureName = name;
		width = texWidth;
		height = texHeight;
		
		texCoords[0].u = leftTexCoord;
		texCoords[0].v = topTexCoord;
		
		texCoords[1].u = rightTexCoord;
		texCoords[1].v = topTexCoord;
		
		texCoords[2].u = rightTexCoord;
		texCoords[2].v = bottomTexCoord;
		
		texCoords[3].u = leftTexCoord;
		texCoords[3].v = bottomTexCoord;
		selfRelease = NO;
	}
	return self;
}

-(TexCoords*)coords {
	
	return texCoords;
}

-(void)dealloc {
	if (selfRelease) {
		glDeleteTextures(1, &textureName);
	}
	[super dealloc];
}

@end

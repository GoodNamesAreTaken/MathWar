//
//  FFTextureRender.h
//  MathWars
//
//  Created by Inf on 26.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFGenericRenderer.h"
#import "FFTexture.h"

@interface FFTextureRender : FFGenericRenderer {
	GLuint texture;
	GLuint framebuffer;
	
	GLuint width;
	GLuint height;
}

@property(readonly) GLuint textureId;
@property(readonly) GLuint width;
@property(readonly) GLuint height;

+(id)textureRendererWithWidth:(GLuint)width height:(GLuint)height;
-(id)initWithWidth:(GLuint)textureWidth height:(GLuint)textureHeight;
-(FFTexture*)buildFFTexture;

@end

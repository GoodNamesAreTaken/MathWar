//
//  FFTextureRender.m
//  MathWars
//
//  Created by Inf on 26.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "FFGame.h"
#import "FFTextureRender.h"


@implementation FFTextureRender
@synthesize width, height, textureId=texture;

+(id)textureRendererWithWidth:(GLuint)width height:(GLuint)height {
	return [[[FFTextureRender alloc] initWithWidth:width height:height] autorelease];
}

-(id)initWithWidth:(GLuint)textureWidth height:(GLuint)textureHeight {
	if (self = [super init]) {
		
		width  = textureWidth;
		height = textureHeight;
	}
	return self;
}

-(void)beforeRender {
	
	glGenTextures(1, &texture);
	
	glBindTexture(GL_TEXTURE_2D, texture);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, NULL);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	
	
	glGenFramebuffersOES(1, &framebuffer);
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, framebuffer);
	glFramebufferTexture2DOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_TEXTURE_2D, texture, 0);
	glBindTexture(GL_TEXTURE_2D, 0);
	
	if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
		NSLog(@"incomplete");
	}
	
	glViewport(0, 0, width, height);
	glMatrixMode(GL_PROJECTION);
	glPushMatrix();
	glLoadIdentity();
	glOrthof(0, width, height, 0, -100.0f, 100.0f);
	glClear(GL_COLOR_BUFFER_BIT);
}

-(void)afterRender {

	glPopMatrix();
	glMatrixMode(GL_MODELVIEW);

}

-(FFTexture*)buildFFTexture {
	FFTexture* result = [FFTexture textureWithName:texture width:width height:height top:1.0f left:0.0f bottom:0.0f right:1.0f];
	result.selfRelease = YES;
	return result;
}

-(void)dealloc {
	glDeleteFramebuffersOES(1, &framebuffer);
	[super dealloc];
}

@end

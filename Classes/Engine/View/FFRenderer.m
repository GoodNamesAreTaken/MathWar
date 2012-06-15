//
//  BatchRenderer.m
//  SimpleRPG
//
//  Created by Inf on 16.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFBatch.h"
#import "FFRenderer.h"
#import "FFGame.h"

@interface FFRenderer(Private)

-(void)setupGL;

@end



@implementation FFRenderer
@synthesize screenWidth, screenHeight, angle, context;

-(id)init {
	if (self = [super init]) {
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        angle = 0;
        if (!context || ![EAGLContext setCurrentContext:context])
		{
            [self release];
            return nil;
        }
		
		[self setup];
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
		
		textureStorage = [[FFTextureStorage alloc] init];
		fontManager = [[FFFontManager alloc] init];
		backWidth = [[UIScreen mainScreen] bounds].size.width;
		backHeight = [[UIScreen mainScreen] bounds].size.height;
		//nodes = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)beforeRender {
	[EAGLContext setCurrentContext:context];
    
	
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
    glViewport(0, 0, backWidth, backHeight);
	glClear(GL_COLOR_BUFFER_BIT);
}

-(void)afterRender {
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
	
}

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer
{	
	// Allocate color buffer backing based on the current layer size
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, (GLint*)&backWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, (GLint*)&backHeight);
	
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
	[self setupGL];
    
    return YES;
}



- (FFTexture*)loadTexture:(NSString*)name {
	name = [name stringByReplacingOccurrencesOfString:@"$w" withString:[NSString stringWithFormat:@"%d", self.screenWidth]];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		name = [name stringByReplacingOccurrencesOfString:@"$d" withString:@"iPad"];
	} else {
		name = [name stringByReplacingOccurrencesOfString:@"$d" withString:@"iPhone"];
	}

	
	return [textureStorage getTexture:name];
}

-(FFTextureAtlas*)loadAtlas:(NSString *)name {
	return [textureStorage getAtlas:name];
}

- (FFFont*) loadFont:(NSString *)name {
	return [fontManager getFontByName:name usingTextureManager:textureStorage];
}

-(void)setAngle:(float)newAngle {
	angle = newAngle;
	[self setupGL];
}

-(void)setupGL {
	glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
	glEnable(GL_TEXTURE_2D);
	glEnable(GL_BLEND);
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);
	
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	
	glRotatef(angle, 0.0f, 0.0f, 1.0f);
	

	glOrthof(0.0f, self.screenWidth, self.screenHeight, 0.0f, -100.0f, 100.0f);

	
	
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	
}

-(uint32_t)screenWidth {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return backWidth;
	}
	
	if (UIDeviceOrientationIsLandscape([FFGame sharedGame].orientation)) {
		return backHeight;
	}
	return backWidth;
}

-(uint32_t)screenHeight {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return backHeight;
	}
	if (UIDeviceOrientationIsLandscape([FFGame sharedGame].orientation)) {
		return backWidth;
	}
	return backHeight;
}

-(void)unloadAtlas:(NSString*)name {
	[textureStorage unloadAtlas:name];
}

-(void)dealloc {

	[fontManager release];
	[textureStorage release];
	
	if (defaultFramebuffer)
	{
		glDeleteFramebuffersOES(1, &defaultFramebuffer);
		defaultFramebuffer = 0;
	}
	
	if (colorRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &colorRenderbuffer);
		colorRenderbuffer = 0;
	}
	
	if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
	[context release];
	context = nil;
	
	[super dealloc];
}
@end

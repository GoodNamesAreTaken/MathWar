//
//  GenericRenderer.h
//  MathWars
//
//  Created by Inf on 26.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//


#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>

#import "Structs.h"
#import "FFCBatchNode.h"
#define NODE_BLOCK 100


@interface FFGenericRenderer : NSObject {
	PBatchNode* nodes;
	uint32_t nodeCount;
	
	GLuint vertexBuffer;
	GLuint indexBuffer;
	
}

-(void)beforeRender;

-(void)afterRender;

-(void)render;

-(void)addNode:(PBatchNode)node;

-(void)removeNode:(PBatchNode)node;
-(void)setup;
-(void)resort;
@end

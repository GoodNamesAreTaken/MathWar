//
//  Batch.h
//  SimpleRPG
//
//  Created by Inf on 17.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Structs.h"
#import "FFGenericRenderer.h"
#include "FFCBatchNode.h"

#define VERTEX_BUFFER_SIZE 500
#define INDEX_BUFFER_SIZE 1000

@interface FFBatch : NSObject {
	uint32_t textureId;
	uint32_t layer;
	
	GLuint vertexBuffer;
	GLuint indexBuffer;
	
	Vertex* vertexData;//[VERTEX_BUFFER_SIZE];
	uint16_t* indexData;//[INDEX_BUFFER_SIZE];
	
	uint32_t vertexOffset;
	uint32_t indexOffset;
}

@property(readonly) uint32_t verticesRemaing;
@property(readonly) uint32_t indicesRemainig;

+(id)batchWithFirstNode:(PBatchNode)firstNode vertexBuffer:(GLuint)vb indexBuffer:(GLuint)ib;
-(id)initWithFirstNode:(PBatchNode)firstNode vertexBuffer:(GLuint)vb indexBuffer:(GLuint)ib;
-(void)flush;
-(void)pushNode:(PBatchNode)node;

@end

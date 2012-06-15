//
//  GenericRenderer.m
//  MathWars
//
//  Created by Inf on 26.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFGenericRenderer.h"
#import "FFBatch.h"


@implementation FFGenericRenderer

-(id)init {
	if (self = [super init]) {
		nodes = calloc(NODE_BLOCK, sizeof(PBatchNode));
		nodeCount = NODE_BLOCK;
		
	}
	return self;
}

-(void)render {
	
	[self beforeRender];
	
	if (nodeCount > 0 && nodes[0] != NULL) {
		
		FFBatch* batch = [FFBatch batchWithFirstNode:nodes[0] vertexBuffer:vertexBuffer indexBuffer:indexBuffer];
		
		for (int i=1; i<nodeCount; i++) {
			if (nodes[i] == NULL) {
				break;
			}
			[batch pushNode:nodes[i]];
		}
		
		[batch flush];
	}
	
	[self afterRender];
	
}

-(void)setup {
	glGenBuffers(1, &vertexBuffer);
	glGenBuffers(1, &indexBuffer);
	
	glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
	
	glBufferData(GL_ARRAY_BUFFER, VERTEX_BUFFER_SIZE*sizeof(Vertex), NULL, GL_DYNAMIC_DRAW);
	
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, INDEX_BUFFER_SIZE*sizeof(uint16_t), NULL, GL_DYNAMIC_DRAW);
}

-(void)addNode:(PBatchNode)node {
	
	BOOL needRealloc = YES;
	for (int i=0; i<nodeCount; i++) {
		if (nodes[i] == NULL) {
			nodes[i] = node;
			needRealloc = NO;
			break;
		}
	}
	
	if (needRealloc) {
		size_t newCount = nodeCount + NODE_BLOCK;
		nodes = realloc(nodes, newCount*sizeof(PBatchNode));
		memset(nodes + nodeCount, 0, NODE_BLOCK*sizeof(PBatchNode));
		nodes[nodeCount] = node;
		nodeCount = newCount;
	}
	[self resort];
}

-(void)resort {
	qsort(nodes, nodeCount, sizeof(PBatchNode), ffBatchNodeCompare);
}

-(void)removeNode:(PBatchNode)node {
	
	for (int i=0; i<nodeCount && nodes[i]; i++) {
		if (nodes[i] == node) {
			nodes[i] = NULL;
			break;
		}
	}
	qsort(nodes, nodeCount, sizeof(PBatchNode), ffBatchNodeCompare);
}

-(void)beforeRender {
	[self doesNotRecognizeSelector:_cmd];
}

-(void)afterRender {
	[self doesNotRecognizeSelector:_cmd];
}

-(void)dealloc {
	free(nodes);
	glDeleteBuffers(1, &vertexBuffer);
	glDeleteBuffers(1, &indexBuffer);
	[super dealloc];
}

@end

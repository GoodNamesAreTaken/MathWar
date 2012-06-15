//
//  Batch.m
//  SimpleRPG
//
//  Created by Inf on 17.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "FFBatch.h"



@implementation FFBatch

+(id)batchWithFirstNode:(PBatchNode)firstNode vertexBuffer:(GLuint)vb indexBuffer:(GLuint)ib {
	return [[[FFBatch alloc] initWithFirstNode:firstNode vertexBuffer:vb indexBuffer:ib] autorelease];
}

-(id)initWithFirstNode:(PBatchNode)firstNode vertexBuffer:(GLuint)vb indexBuffer:(GLuint)ib {
	if (self = [super init]) {
		layer = firstNode->layer;
		
		textureId = firstNode->textureId;
		glBindTexture(GL_TEXTURE_2D, textureId);
		
		
		
		vertexBuffer = vb;
		indexBuffer = ib;
		
		glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);

		glVertexPointer(2, GL_SHORT, sizeof(Vertex), (void*)offsetof(Vertex, position));//&vertexData[0].position);
		glTexCoordPointer(2, GL_FLOAT, sizeof(Vertex), (void*)offsetof(Vertex, texture));
		glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(Vertex), (void*)offsetof(Vertex, color));

		vertexData = glMapBufferOES(GL_ARRAY_BUFFER, GL_WRITE_ONLY_OES);
		indexData = glMapBufferOES(GL_ELEMENT_ARRAY_BUFFER, GL_WRITE_ONLY_OES);
		//Копируем вершины в буфер
		memcpy(vertexData, firstNode->vertices, firstNode->vertexCount * sizeof(Vertex));
		
		//Копируем индексы в буфер
		memcpy(indexData, firstNode->indices, firstNode->indexCount * sizeof(uint16_t));
		
		vertexOffset = firstNode->vertexCount;
		indexOffset = firstNode->indexCount;
	}
	return self;
}

-(void)flushAndRemap {
	[self flush];
	vertexData = glMapBufferOES(GL_ARRAY_BUFFER, GL_WRITE_ONLY_OES);
	indexData = glMapBufferOES(GL_ELEMENT_ARRAY_BUFFER, GL_WRITE_ONLY_OES);
	vertexOffset = indexOffset = 0;
}

-(void)pushNode:(PBatchNode)node {
	if (self.indicesRemainig < node->indexCount || self.verticesRemaing < node->vertexCount) {
		[self flushAndRemap];
	}
	
	if (node->layer != layer) {
		[self flushAndRemap];
		layer = node->layer;
		if (textureId != node->textureId) {
			textureId = node->textureId;
			glBindTexture(GL_TEXTURE_2D, textureId);
		}
	} else if (textureId != node->textureId) {
		[self flushAndRemap];
		textureId = node->textureId;
		glBindTexture(GL_TEXTURE_2D, textureId);
	}	
	//Копируем вершины в буфер
	memcpy(vertexData + vertexOffset, node->vertices, node->vertexCount * sizeof(Vertex));
	
	//Копируем и поправляем индексы
	for (int idx=0; idx<node->indexCount; idx++) {
		indexData[indexOffset + idx] = node->indices[idx] + vertexOffset;
	}
	
	vertexOffset += node->vertexCount;
	indexOffset += node->indexCount;
}

-(void)flush {
	glUnmapBufferOES(GL_ARRAY_BUFFER);
	glUnmapBufferOES(GL_ELEMENT_ARRAY_BUFFER);
	
	glDrawElements(GL_TRIANGLES, indexOffset, GL_UNSIGNED_SHORT, 0);
}

-(uint32_t)verticesRemaing {
	return VERTEX_BUFFER_SIZE - vertexOffset;
}

-(uint32_t)indicesRemainig {
	return INDEX_BUFFER_SIZE - indexOffset;
}

@end

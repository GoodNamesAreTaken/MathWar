/*
 *  FFCBatchNode.h
 *  MathWars
 *
 *  Created by Inf on 26.05.10.
 *  Copyright 2010 Soulteam. All rights reserved.
 *
 */

#ifndef FF_BATCH_NODE_H
#define FF_BATCH_NODE_H

#include <stdint.h>


#include "Structs.h"

enum PrimitiveType {
	PTTriangleList,
	PTPointList	
};

typedef struct _FFCBatchNode {
	uint32_t layer;
	uint32_t textureId;	
	Vertex* vertices;
	uint16_t* indices;
	
	uint32_t vertexCount;
	uint32_t indexCount;
}FFCBatchNode, *PBatchNode;

void ffBatchNodeInit(PBatchNode node, uint32_t vertexCount, uint32_t indexCount);

void ffBatchNodeSetVertexCount(PBatchNode node, int vertexCount);

void ffBatchNodeSetIndexCount(PBatchNode node, int indexCount);

void ffBatchNodeDestroy(PBatchNode node);

int ffBatchNodeCompare(const void* pfirst, const void* psecond);

#endif

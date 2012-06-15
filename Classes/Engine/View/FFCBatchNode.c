/*
 *  FFCBatchNode.c
 *  MathWars
 *
 *  Created by Inf on 26.05.10.
 *  Copyright 2010 Soulteam. All rights reserved.
 *
 */

#include "FFCBatchNode.h"
#include <stdlib.h>
#include <string.h>

void ffBatchNodeInit(PBatchNode node, uint32_t vertexCount, uint32_t indexCount) {
	memset(node, 0, sizeof(FFCBatchNode));
	node->vertexCount = vertexCount;
	node->indexCount = indexCount;
	
	node->vertices = malloc(sizeof(Vertex) * vertexCount);
	node->indices = malloc(sizeof(uint16_t) * indexCount);
	
	for (int i = 0; i< vertexCount; i++) {
		node->vertices[i].color.r = node->vertices[i].color.g = node->vertices[i].color.b = node->vertices[i].color.a = 255;
	}
}

void ffBatchNodeSetVertexCount(PBatchNode node, int vertexCount) {
	node->vertexCount = vertexCount;
	node->vertices = realloc(node->vertices, sizeof(Vertex)*vertexCount);
}

void ffBatchNodeSetIndexCount(PBatchNode node, int indexCount) {
	node->indexCount = indexCount;
	node->indices = realloc(node->indices, sizeof(uint16_t)*indexCount);
}

void ffBatchNodeDestroy(PBatchNode node) {
	free(node->vertices);
	node->vertices = NULL;
	free(node->indices);
	node->indices = NULL;
}

int ffBatchNodeCompare(const void* pfirst, const void* psecond) {
	
	PBatchNode first = *(PBatchNode*)pfirst;
	PBatchNode second = *(PBatchNode*)psecond;
	
	if (first == NULL && second == NULL) {
		return 0;
	}
	
	if (first == NULL) {
		return 1;
	}
	
	if (second == NULL) {
		return -1;
	}
	
	if (first->layer > second->layer) {
		return 1;
	}
	
	if (first->layer < second->layer) {
		return -1;
	}
	
	if (first->textureId > second->textureId) {
		return 1;
	}
	
	if (first->textureId < second->textureId) {
		return -1;
	}
	
	
	return 0;
}
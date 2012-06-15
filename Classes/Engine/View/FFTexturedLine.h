//
//  FFTexturedLine.h
//  MathWars
//
//  Created by Inf on 10.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFView.h"
#import "FFTexture.h"
#include "FFCBatchNode.h"
#include "Structs.h"

@interface FFTexturedLine : FFView {
	FFCBatchNode node;
	FFTexture* texture;
	
	VertexCoords orginialVertices[4];
	float angle;
	float length;
	
	float dx;
	float dy;
	
}

+(id)lineFromX:(float)startX y:(float)startY toX:(float)endX y:(float)endY withTextureNamed:(NSString*)name;

-(id)initWithX:(float)startX y:(float)startY endX:(float)endX endY:(float)endY withTexture:(FFTexture*)texture;
@end

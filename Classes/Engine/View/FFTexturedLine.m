//
//  FFTexturedLine.m
//  MathWars
//
//  Created by Inf on 10.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFTexturedLine.h"
#import "FFGame.h"


@implementation FFTexturedLine

+(id)lineFromX:(float)startX y:(float)startY toX:(float)endX y:(float)endY withTextureNamed:(NSString *)name {
	return [[[FFTexturedLine alloc] initWithX:startX y:startY endX:endX endY:endY withTexture:[[FFGame sharedGame].renderer loadTexture:name]] autorelease];
}

#define EPS 0.00001f

-(id)initWithX:(float)startX y:(float)startY endX:(float)endX endY:(float)endY withTexture:(FFTexture*)lineTexture {
	if (self = [super init]) {
		x = startX;
		y = startY;
		
		dx = endX - startX;
		dy = endY - startY;
		length = sqrtf(dx*dx + dy*dy);

		
		if (abs(dx) < EPS) {
			if (dy > 0) {
				angle = 0.5 * M_PI;
			} else {
				angle = - 0.5*M_PI;
			}

		} else if (dx > 0) {
			angle = atanf(dy/dx);
		} else {
			angle = M_PI + atanf(dy/dx);
		}
		

		
		texture = [lineTexture retain];
		
		ffBatchNodeInit(&node, 4, 6);
		
		node.indices[0] = 3;
		node.indices[1] = 0;
		node.indices[2] = 1;
		
		node.indices[3] = 3;
		node.indices[4] = 1;
		node.indices[5] = 2;
		node.textureId = texture.name;
		
		for (int i=0; i<4; i++) {
			node.vertices[i].texture = texture.coords[i];
			node.vertices[i].color.r = node.vertices[i].color.g =	node.vertices[i].color.b = node.vertices[i].color.a = 255;
		}
		
		[self updateAbsoluteLayer];
		[self updateAbsolutePosition];
		
	}
	return self;
}

-(void)updateAbsoluteLayer {
	node.layer = self.absoluteLayer;
}

-(void)rotate {
	float centerX = self.absoluteX;
	float centerY = self.absoluteY;
	
	for (int i=0; i<node.vertexCount; i++) {
		node.vertices[i].position.x = centerX + (orginialVertices[i].x - centerX) * cosf(angle) - (orginialVertices[i].y - centerY) * sinf(angle);
		node.vertices[i].position.y = centerY + (orginialVertices[i].x - centerX) * sinf(angle) + (orginialVertices[i].y - centerY) * cosf(angle);
	}
}

-(void)updateAbsoluteX {
	[super updateAbsoluteX];
	

	orginialVertices[0].x = orginialVertices[3].x = self.absoluteX;
	orginialVertices[1].x = orginialVertices[2].x = self.absoluteX + length;
	[self rotate];
}

-(void)updateAbsoluteY {
	[super updateAbsoluteY];
	
	float halfHeight = texture.height * 0.5f;
	orginialVertices[0].y = orginialVertices[1].y = self.absoluteY - halfHeight; 
	orginialVertices[2].y = orginialVertices[3].y = self.absoluteY + halfHeight;
	[self rotate];
}

-(void)showIn:(FFGenericRenderer *)renderer {
	[renderer addNode:&node];
}

-(void)hideIn:(FFGenericRenderer *)renderer {
	[renderer removeNode:&node];
}

-(void)dealloc {
	ffBatchNodeDestroy(&node);
	[texture release];
	[super dealloc];
}

@end

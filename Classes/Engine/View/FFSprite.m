//
//  BatchSprite.m
//  SimpleRPG
//
//  Created by Inf on 17.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFSprite.h"
#import "FFGame.h"
#include "FFCBatchNode.h"


@implementation FFSprite
@synthesize texture, mirror;

+(id)spriteWithTextureNamed:(NSString*)textureName {
	return [[[FFSprite alloc] initWithTextureNamed:textureName] autorelease];
}

+(id)spriteWithTexture:(FFTexture*)texture {
	return [[[FFSprite alloc] initWithTexture:texture] autorelease];
}

-(id)init {
	
	if (self = [super init]) {
		ffBatchNodeInit(&node, 4, 6);
		
		node.indices[0] = 3;
		node.indices[1] = 0;
		node.indices[2] = 1;
		
		node.indices[3] = 3;
		node.indices[4] = 1;
		node.indices[5] = 2;
		
		self.x = self.y = 0;
	}
	
	return self;	

}

- (id)initWithTextureNamed: (NSString*) textureName {
	return [self initWithTexture:[[FFGame sharedGame].renderer loadTexture:textureName]];
}

- (id)initWithTexture: (FFTexture*) textureImage {
	if (self = [super init]) {
		if (!textureImage) {
			[self release];
			return nil;
		}
		
		//node = [[FFBatchNode alloc] initWithVertexCount:4 indexCount:6];
		ffBatchNodeInit(&node, 4, 6);
		
	
		self.texture = textureImage;
		
		node.indices[0] = 3;
		node.indices[1] = 0;
		node.indices[2] = 1;
		
		node.indices[3] = 3;
		node.indices[4] = 1;
		node.indices[5] = 2;
		
		self.x = self.y = 0;
	}
	return self;
}

-(void)calculateTexCoords {
	if (mirror) {
		node.vertices[0].texture = texture.coords[1];
		node.vertices[1].texture = texture.coords[0];
		node.vertices[2].texture = texture.coords[3];
		node.vertices[3].texture = texture.coords[2];
	} else {
		for (int i=0; i<4; i++) {
			node.vertices[i].texture = texture.coords[i];
		}
	}
}

-(void)setTexture:(FFTexture*)newTexture {
	if (texture != newTexture) {
		[texture release];
		texture = [newTexture retain];
		node.textureId = texture.name;
		
		[self calculateTexCoords];

		
		[self updateAbsoluteX];
		[self updateAbsoluteY];
	}
	
}

-(void)setMirror:(BOOL)value {
	mirror = value;
	[self calculateTexCoords];
}

-(void)setBackgroundColorR:(float)r g:(float)g b:(float)b a:(float)a {
	for (int i = 0; i < 4; i++) {
		node.vertices[i].color.r = r;
		node.vertices[i].color.g = g;
		node.vertices[i].color.b = b;
		node.vertices[i].color.a = a;
	}
}

-(float)width {
	return texture.width;
}

-(float)height {
	return texture.height;
}

-(void)showIn:(FFGenericRenderer*)renderer {
	[renderer addNode:&node];
}

-(void)hideIn:(FFGenericRenderer*)renderer {
	[renderer removeNode:&node];
}

-(void)updateAbsoluteX {
	[super updateAbsoluteX];
	float halfWidth = self.width * 0.5f;
	node.vertices[0].position.x = node.vertices[3].position.x = self.absoluteX - halfWidth;
	node.vertices[1].position.x = node.vertices[2].position.x = self.absoluteX + halfWidth;
}

-(void)updateAbsoluteY {
	[super updateAbsoluteY];
	float halfHeight = self.height * 0.5f;
	node.vertices[0].position.y = node.vertices[1].position.y = self.absoluteY - halfHeight;
	node.vertices[2].position.y = node.vertices[3].position.y = self.absoluteY + halfHeight;
}

-(void)updateAbsoluteLayer {
	node.layer = self.absoluteLayer;
}

-(BOOL)pointInside:(CGPoint)point {
	return point.x >= (self.absoluteX - self.width * 0.5f)
			&& point.x <= (self.absoluteX + self.width * 0.5f) 
			&& point.y >= (self.absoluteY - self.height * 0.5f) 
			&& point.y <= (self.absoluteY + self.height * 0.5f);
}

-(void)dealloc {
	[self hide];
	[texture release];
	ffBatchNodeDestroy(&node);
	
	[super dealloc];
}
				

@end

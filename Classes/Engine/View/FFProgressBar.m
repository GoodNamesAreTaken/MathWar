//
//  BasicSlider.m
//  SimpleRPG
//
//  Created by Inf on 18.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "FFGame.h"
#import "FFProgressBar.h"


@implementation FFProgressBar
@synthesize value, maxValue;

-(id)initWithTextureNamed:(NSString *)textureName {
	if (self = [super init]) {
		texture = [[[FFGame sharedGame].renderer loadTexture:textureName] retain];
		
		ffBatchNodeInit(&node, 4, 6);
		maxValue = value = 100.0f;
		
		node.textureId = texture.name;
		
		node.indices[0] = 3;
		node.indices[1] = 0;
		node.indices[2] = 1;
		
		node.indices[3] = 3;
		node.indices[4] = 1;
		node.indices[5] = 2;
		
		for (int i=0; i<4; i++) {
			node.vertices[i].texture = texture.coords[i];
		}
	}
	return self;
}

-(void)showIn:(FFRenderer*)renderer {
	[renderer addNode:&node];
}

-(void)hideIn:(FFRenderer*)renderer {
	[renderer removeNode:&node];
}

-(void)updateAbsoluteX {
	[super updateAbsoluteX];
	node.vertices[0].position.x = node.vertices[3].position.x = self.absoluteX;
	node.vertices[1].position.x = node.vertices[2].position.x = self.absoluteX + texture.width;
}

-(void)updateAbsoluteY {
	[super updateAbsoluteY];
	float percent = value / maxValue;
	node.vertices[0].position.y= node.vertices[1].position.y = self.absoluteY + (1.0f - percent) * texture.height;
	
	node.vertices[3].position.y = node.vertices[2].position.y = self.absoluteY + texture.height;
	
	if (fabs(percent - 1.0f) < 0.00001f) {
		for (int i=0; i<4; i++) {
			node.vertices[i].color.r = node.vertices[i].color.b = 0;
			node.vertices[i].color.g = node.vertices[i].color.a = 255;
		}
	} else if (percent > 0.4) {
		for (int i=0; i<4; i++) {
			node.vertices[i].color.r = node.vertices[i].color.g = node.vertices[i].color.a = 255;
			node.vertices[i].color.b = 0;
		}
	} else {
		for (int i=0; i<4; i++) {
			node.vertices[i].color.r = node.vertices[i].color.a = 255;
			node.vertices[i].color.b = node.vertices[i].color.g = 0;
		}
	}
}

-(void)updateAbsoluteLayer {
	node.layer = self.absoluteLayer;
}

-(void)setValue:(float)newValue {
	value = newValue;
	[self updateAbsoluteY];
}

-(void)setMaxValue:(float)newMax {
	maxValue = newMax;
	[self updateAbsoluteY];
}

-(float)width {
	return texture.width;
}

-(float)height {
	return texture.height;
}

-(void)dealloc {
	ffBatchNodeDestroy(&node);
	[texture release];
	[super dealloc];
}

@end

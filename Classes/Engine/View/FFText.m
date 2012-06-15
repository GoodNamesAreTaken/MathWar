//
//  BatchText.m
//  SimpleRPG
//
//  Created by Inf on 17.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFText.h"
#import "FFGame.h"

#include "FFCBatchNode.h"


@implementation FFText
@synthesize label;

+(id)textWithFont:(FFFont*)font {
	return [[[FFText alloc] initWithFont:font] autorelease];
}

+(id)textWithFontNamed:(NSString*) fontName {
	return [[[FFText alloc] initWithFontNamed:fontName] autorelease];
}

-(id)initWithFontNamed:(NSString *)fontName {
	FFFont* loadedFont = [[FFGame sharedGame].renderer loadFont:fontName];
	return [self initWithFont:loadedFont];
}

-(id)initWithFont:(FFFont *)textFont {
	if (self = [super init]) {
		if (textFont == nil) {
			[self release];
			return nil;
		}
		font = [textFont retain];
		
		node.textureId = font.texture.textureId;
		
		color.r = color.g = color.b = color.a = 255;
	}
	return self;
}

-(float)height {
	return font.height;
}

-(float)width {
	return [font widthOfText:label];
}

-(void)showIn:(FFGenericRenderer*)renderer {
	[renderer addNode:&node];
}

-(void)hideIn:(FFGenericRenderer*)renderer {
	[renderer removeNode:&node];
}

-(void)setLabel:(NSString *)newLabel {
	
	if (label != newLabel) {
		[label release];
		label = [newLabel retain];
	}
	
	ffBatchNodeSetVertexCount(&node, label.length*4);
	ffBatchNodeSetIndexCount(&node, label.length*6);
	
	
	uint32_t index = 0;
	uint32_t vertex = 0;
	for (uint32_t i=0; i<label.length; i++) {
		FFFontCharacter* character = [font getCharacter:[label characterAtIndex:i]];
		
		
		node.vertices[vertex].texture = character.texcoords[0];  
		node.vertices[vertex].color = color;
		node.vertices[vertex + 1].texture = character.texcoords[1];
		node.vertices[vertex + 1].color = color;
		node.vertices[vertex + 2].texture = character.texcoords[2];
		node.vertices[vertex + 2].color = color;
		node.vertices[vertex + 3].texture = character.texcoords[3];
		node.vertices[vertex + 3].color = color;
		
		node.indices[index] = vertex + 3;
		node.indices[index + 1] = vertex + 1;
		node.indices[index + 2] = vertex;
		
		node.indices[index + 3] = vertex + 2;
		node.indices[index + 4] = vertex + 3;
		node.indices[index + 5] = vertex + 1;
		
		vertex += 4;
		index += 6;
		
		
	}
	[self updateAbsoluteX];
	[self updateAbsoluteY];
}

-(void)updateAbsoluteX {
	[super updateAbsoluteX];
	uint32_t vertex = 0;
	float width = 0;
	for (uint32_t i=0; i<label.length; i++) {
		FFFontCharacter* character = [font getCharacter:[label characterAtIndex:i]];
		
		node.vertices[vertex].position.x = self.absoluteX + character.xoffset + width;
		node.vertices[vertex + 2].position.x = node.vertices[vertex].position.x + character.width;
		node.vertices[vertex + 1].position.x = node.vertices[vertex + 2].position.x;
		node.vertices[vertex + 3].position.x = node.vertices[vertex].position.x;
		
		vertex += 4;
		width += character.xadvance;
	}
}

-(void)updateAbsoluteY {
	[super updateAbsoluteY];
	uint32_t vertex = 0;
	for (uint32_t i=0; i<label.length; i++) {
		FFFontCharacter* character = [font getCharacter:[label characterAtIndex:i]];
		
		node.vertices[vertex].position.y = self.absoluteY + character.yoffset;
		node.vertices[vertex + 2].position.y = node.vertices[vertex].position.y + character.height;
		node.vertices[vertex + 1].position.y = node.vertices[vertex].position.y;
		node.vertices[vertex + 3].position.y = node.vertices[vertex + 2].position.y;
		vertex += 4;
	}
}

-(void)updateAbsoluteLayer {
	node.layer = self.absoluteLayer;
}

-(BOOL)pointInside:(CGPoint)point {
	return point.x >= self.absoluteX && point.x <= self.absoluteX + self.width && point.y >= self.absoluteY && point.y <= self.absoluteY + self.height;
}

- (void) setColorR:(uint8_t)r G:(uint8_t)g B:(uint8_t)b A:(uint8_t)a;{
	color.r = r;
	color.g = g;
	color.b = b;
	color.a = a;
	for (int i=0; i<node.vertexCount; i++) {
		node.vertices[i].color.r = color.r;
		node.vertices[i].color.g = color.g;
		node.vertices[i].color.b = color.b;
		node.vertices[i].color.a = color.a;
	}
}

-(void)dealloc {
	[self hide];
	
	ffBatchNodeDestroy(&node);
	[font release];
	[label release];
	[super dealloc];
}

@end

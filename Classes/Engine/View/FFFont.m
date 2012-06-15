//
//  Font.m
//  Rocket
//
//  Created by Inf on 12.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#include <inttypes.h>
#import "FFFont.h"
#import "FFTexture.h"



#define BLOCK_FONT_INFO 1
#define BLOCK_CHARACTERS_INFO 4

struct CharData {
	uint32_t charId;
	uint16_t x;
	uint16_t y;
	uint16_t width;
	uint16_t height;
	int16_t xoffset;
	int16_t yoffset;
	int16_t xadvance;
	uint8_t page;
	uint8_t channel;
}__attribute__((packed));

@implementation FFFontCharacter
@synthesize width, height, xoffset, yoffset, xadvance;

-(id)initWithX:(int)x y:(int)y width:(int)letterWidth height:(int)letterHeight onTexture:(FFTextureAtlas*)texture {
	if ([super init]) {
		width = letterWidth;
		height = letterHeight;
		
		//левый верхний угол
		texcoords[3].u = (float)x / texture.width + texture.halfTexelWidth;
		texcoords[3].v = (float)(y + height) / texture.height - texture.halfTexelHeight;
		
		texcoords[1].u = (float)(x + width) / texture.width - texture.halfTexelWidth;
		texcoords[1].v = (float)y / texture.height + texture.halfTexelHeight;
		
		
		texcoords[0].u = texcoords[3].u;
		texcoords[0].v = texcoords[1].v;
		
		texcoords[2].u = texcoords[1].u;
		texcoords[2].v = texcoords[3].v;
	}
	return self;
}

-(TexCoords*) texcoords {
	return texcoords;
}

@end

@interface FFFont(Private)
- (void) readCharactersFrom: (NSData *) binaryData at:(uint32_t) offset length:(uint32_t) blockSize;
- (void) readFontInfoFrom: (NSData *) binaryData at: (uint32_t) offset;
@end


@implementation FFFont
@synthesize texture;
@synthesize height;

- (id) initWithTexture: (FFTextureAtlas*) fontTexture fontName:(NSString*)name; {
	if ([super init]) {
		texture = [fontTexture retain];
		NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"fnt"];
		NSData* binaryData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
		
		char header[3];
		[binaryData getBytes:header length:3];
		
		if (strncmp(header, "BMF", 3) != 0) {
			return nil;
		}
		uint32_t offset = 3;
		uint8_t version;
		[binaryData getBytes:&version range:NSMakeRange(offset, 1)];
		
		if (version != 3) {
			return nil;
		}
		offset++;
		
		uint32_t blockSize;
		uint8_t blockId;
		
		while (offset < [binaryData length]) {
			[binaryData getBytes:&blockId range:NSMakeRange(offset, 1)];
			offset++;
			[binaryData getBytes:&blockSize range:NSMakeRange(offset, 4)];
			offset += 4;
			
			switch (blockId) {
				case BLOCK_FONT_INFO:
					[self readFontInfoFrom: binaryData at: offset];
					break;
				case BLOCK_CHARACTERS_INFO:
					[self readCharactersFrom: binaryData at:offset length: blockSize];
					break;
			}
			offset += blockSize;
		}
		
	}
	return self;
}



- (FFFontCharacter*) getCharacter:(unichar)charCode {
	return [letters objectForKey:[NSString stringWithCharacters:&charCode length: 1]];
}

-(float)widthOfText:(NSString *)text {
	float width = 0.0f;
	for (int i=0; i < text.length; i++) {
		unichar character = [text characterAtIndex:i];
		width += [self getCharacter:character].xadvance;
	}
	return width;
}

-(void) dealloc {
	[texture release];
	[letters release];
	[super dealloc];
}

@end

@implementation FFFont(Private) 

- (void) readFontInfoFrom: (NSData *) binaryData at: (uint32_t) offset  {
	int16_t fontHeight;
	[binaryData getBytes:&fontHeight range:NSMakeRange(offset, 2)];
	height = fabs(fontHeight);
}

- (void) readCharactersFrom: (NSData *) binaryData at:(uint32_t) offset length:(uint32_t) blockSize   {
	letters = [[NSMutableDictionary alloc] init];
	while (blockSize > 0) {
		struct CharData data;
		[binaryData getBytes:&data range:NSMakeRange(offset, sizeof data)];
		unichar c = (unichar)data.charId;
		offset += sizeof data;
		blockSize -= sizeof data; 
		FFFontCharacter* character = [[FFFontCharacter alloc] initWithX:data.x y:data.y width:data.width height:data.height onTexture:texture ];
		character.xoffset = data.xoffset;
		character.yoffset = data.yoffset;
		character.xadvance = data.xadvance;
		
		[letters setObject:[character autorelease] forKey:[NSString stringWithCharacters:&c length:1]];
	}
	
}

@end

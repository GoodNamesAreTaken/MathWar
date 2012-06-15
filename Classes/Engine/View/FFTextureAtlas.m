//
//  TextureAtlas.m
//  Rocket
//
//  Created by Inf on 16.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#include <png.h>
#import "FFTextureAtlas.h"

#define PVR_TEXTURE_FLAG_TYPE_MASK	0xff



@implementation FFTextureAtlas
@synthesize textureId;
@synthesize width;
@synthesize height;


-(id)initWithImageNamed:(NSString *)name {
	if (self = [super init]) {
		NSString* path = [[NSBundle mainBundle] pathForResource:[name stringByDeletingPathExtension] ofType:[name pathExtension]];
		
		FILE* imageFile = fopen([path UTF8String], "rb");
		
		if (!imageFile) {
			[self release];
			return nil;
		}
		
		png_structp readStruct = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
		
		if (!readStruct) {
			fclose(imageFile);
			[self release];
			return nil;
		}
		
		png_infop infoStruct = png_create_info_struct(readStruct);
		
		if (!infoStruct) {
			png_destroy_read_struct(&readStruct, NULL, NULL);
			fclose(imageFile);
			[self release];
			return nil;
		}
		
		png_infop endPtr = png_create_info_struct(readStruct);
		
		if (!endPtr) {
			png_destroy_read_struct(&readStruct, &infoStruct, NULL);
			fclose(imageFile);
			[self release];
			return nil;
		}
		
		if (setjmp(png_jmpbuf(readStruct))) {
			png_destroy_read_struct(&readStruct, &infoStruct,
									&endPtr);
			fclose(imageFile);
			[self release];
			return nil;
		}
		
		png_init_io(readStruct, imageFile);
		png_read_info(readStruct, infoStruct);
		
		int colorType, bitDepth;
		png_get_IHDR(readStruct, infoStruct, (png_uint_32p)&width, (png_uint_32p)&height, &bitDepth, &colorType, NULL, NULL, NULL);

		uint32_t rowBytes = png_get_rowbytes(readStruct, infoStruct);

		png_bytep data = (png_bytep)malloc(height*rowBytes);
		
		if (!data) {
			png_destroy_read_struct(&readStruct, &infoStruct,
									&endPtr);
			fclose(imageFile);
			[self release];
			return nil;
		}
		
		
		GLuint textureFormat = 0;
		switch (colorType) {
			case PNG_COLOR_TYPE_RGB_ALPHA:
				textureFormat = GL_RGBA;
				break;
			case PNG_COLOR_TYPE_RGB:
				textureFormat = GL_RGB;
				break;
			default:
				NSLog(@"Unsupported png format");
				png_destroy_read_struct(&readStruct, &infoStruct,
										&endPtr);
				fclose(imageFile);
				[self release];
				return nil;
		}
		
		png_bytep* rows = malloc(sizeof(png_bytep)*height);
		
		if (!rows) {
			free(data);
			png_destroy_read_struct(&readStruct, &infoStruct,
									&endPtr);
			fclose(imageFile);
			[self release];
			return nil;
			
		}
		
		for (uint32_t i=0; i<height; i++) {
			rows[i] = data + i*rowBytes;
		}
		
		png_read_image(readStruct, rows);
		free(rows);
		png_read_end(readStruct, endPtr);
		png_destroy_read_struct(&readStruct, &infoStruct, &endPtr);
		fclose(imageFile);
		
		glGenTextures(1, &textureId);
		glBindTexture(GL_TEXTURE_2D, textureId);
		glTexImage2D(GL_TEXTURE_2D, 0, textureFormat, width, height, 0, textureFormat, GL_UNSIGNED_BYTE, data);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		free(data);
		
	}
	return self;
}

-(float)halfTexelWidth {
	return 0.5f / (float)width;
}

-(float)halfTexelHeight {
	return 0.5f / (float)height;
}

-(void)dealloc {
	glDeleteTextures(1, &textureId);
	[super dealloc];
}

@end

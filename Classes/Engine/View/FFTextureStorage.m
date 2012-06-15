//
//  TextureManager.m
//  Rocket
//
//  Created by Inf on 06.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FFTextureAtlas.h"
#import "FFTexture.h"
#import "FFTextureStorage.h"

@interface FFTextureStorage(Private)

-(FFTextureAtlas*)loadAtlas:(NSString*)name;

@end


@implementation FFTextureStorage

- (id) init {
	if (self = [super init]) {
		atlases = [[NSMutableDictionary alloc] init];
		textures = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"textures" ofType:@"plist"]] retain];
	}
	return self;
}

- (FFTexture*) getTexture:(NSString*)name {
	NSDictionary* texturePrperites = [textures objectForKey:name];
	FFTextureAtlas* atlas = [self getAtlas:[texturePrperites objectForKey:@"atlas"]];
	if (atlas == nil) {
		return nil;
	}
	return [FFTexture textureWithName:atlas.textureId 
							width: [[texturePrperites objectForKey:@"width"] intValue] 
							height:[[texturePrperites objectForKey:@"height"] intValue]  
							top:[[texturePrperites objectForKey:@"top"] floatValue]
							left:[[texturePrperites objectForKey:@"left"] floatValue]
							bottom:[[texturePrperites objectForKey:@"bottom"] floatValue]
							right:[[texturePrperites objectForKey:@"right"] floatValue]
			];
}

-(FFTextureAtlas*)getAtlas:(NSString *)name {
	FFTextureAtlas* atlas = [atlases objectForKey:name];
	if (atlas == nil) {
		return [self loadAtlas:name];
	}
	return atlas;
}

-(void)unloadAtlas:(NSString*)name {
	[atlases removeObjectForKey:name];
}

@end

@implementation FFTextureStorage(Private)

-(FFTextureAtlas*)loadAtlas:(NSString*)name {
	FFTextureAtlas* newAtlas = [[FFTextureAtlas alloc] initWithImageNamed:name];
	[atlases setObject:newAtlas forKey:name];
	return [newAtlas autorelease];
}

@end


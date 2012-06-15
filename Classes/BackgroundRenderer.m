//
//  BackgroundRenderer.m
//  MathWars
//
//  Created by Inf on 11.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "BackgroundRenderer.h"
#import "FFTexturedLine.h"
#import "FFSprite.h"

#define GARBAGE_AMOUNT 7

@implementation BackgroundRenderer

+(id)renderer {
	return [[[BackgroundRenderer alloc] init] autorelease];
}

-(id)init {
	if (self = [super init]) {
		renderer = [[FFTextureRender alloc] initWithWidth:1024 height:1024];
		[renderer setup];
	}
	return self;
}

-(void)addRoadFromX:(float)x y:(float)y toX:(float)endX y:(float)endY {
	
	FFTexturedLine* road = [FFTexturedLine lineFromX:x y:y toX:endX y:endY withTextureNamed:@"lineBlock.png"];
	road.layer = 2;
	[road showIn:renderer];
}


-(void)createTilesPerX:(uint32_t)tilesPerX perY:(uint32_t)tilesPerY {
	for (int i=0; i<tilesPerX; i++) {
		for (int j=0; j<tilesPerY; j++) {
			FFSprite* tile = [[FFSprite alloc] initWithTextureNamed:@"tile.png"];
			tile.x = tile.width * 0.5f + i*tile.width;
			tile.y = tile.height * 0.5f + j*tile.height;
			
			[tile showIn:renderer];
			[tile autorelease];
		}
	}
}

-(void)addGarbage {
	FFSprite* garbage;
	int rand = arc4random() % GARBAGE_AMOUNT;
	switch (rand) {
		case 0:
			garbage = [FFSprite spriteWithTextureNamed:@"bush1.png"];
			break;
		case 1:
			garbage = [FFSprite spriteWithTextureNamed:@"bush2.png"];
			break;
		case 2:
			garbage = [FFSprite spriteWithTextureNamed:@"rock1.png"];
			break;
		case 3:
			garbage = [FFSprite spriteWithTextureNamed:@"rock2.png"];
			break;
		case 4:
			garbage = [FFSprite spriteWithTextureNamed:@"sand1.png"];
			break;
		case 5:
			garbage = [FFSprite spriteWithTextureNamed:@"sand2.png"];
			break;
		case 6:
			garbage = [FFSprite spriteWithTextureNamed:@"sand3.png"];
			break;
		default:
			NSLog(@"Unknown garbage type");
			return;
	}
	garbage.x = arc4random() % 1024;
	garbage.y = arc4random() % 1024;
	garbage.layer = 1;
	[garbage showIn:renderer];
	
}

-(FFTexture*)createTexture {
	[renderer performSelectorOnMainThread:@selector(render) withObject:nil waitUntilDone:YES];
	return [renderer buildFFTexture];
}

-(void)dealloc {
	[renderer release];
	[super dealloc];
}
@end

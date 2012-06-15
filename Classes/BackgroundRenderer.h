//
//  BackgroundRenderer.h
//  MathWars
//
//  Created by Inf on 11.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFTextureRender.h"
#import "FFTexture.h"


@interface BackgroundRenderer : NSObject {
	FFTextureRender* renderer;
}

+(id)renderer;

-(void)addRoadFromX:(float)x y:(float)y toX:(float)endX y:(float)endY;
-(void)createTilesPerX:(uint32_t)tilesPerX perY:(uint32_t)tilesPerY;
-(void)addGarbage;
-(FFTexture*)createTexture;

@end

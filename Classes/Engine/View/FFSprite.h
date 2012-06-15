//
//  BatchSprite.h
//  SimpleRPG
//
//  Created by Inf on 17.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFView.h"
#import "FFTexture.h"
#include "FFCBatchNode.h"

@interface FFSprite : FFView {
	FFTexture* texture;
	FFCBatchNode node;
	BOOL mirror;
}

@property(nonatomic, readonly) float width;
@property(nonatomic, readonly) float height;
@property(nonatomic) BOOL mirror;
@property(nonatomic, retain) FFTexture* texture;

+(id)spriteWithTextureNamed:(NSString*)textureName;
+(id)spriteWithTexture:(FFTexture*)texture;

- (id)initWithTextureNamed: (NSString*) textureName;
-(id)initWithTexture:(FFTexture*)spriteTexture;

-(void)setBackgroundColorR:(float)r g:(float)g b:(float)b a:(float)a;
@end

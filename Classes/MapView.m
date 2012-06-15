//
//  MapView.m
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MapView.h"
#import "FFSprite.h"
#import "FFTextureRender.h"
#import "FFGame.h"
#import "GameUI.h"

#define TILES_PER_X 8 
#define TILES_PER_Y 8
#define TILE_SIZE 128.0f

#define WIDTH TILES_PER_X * TILE_SIZE
#define HEIGHT TILES_PER_Y * TILE_SIZE


@implementation MapView
@synthesize topBound, bottomBound, leftBound, rightBound;


-(id)init {
	if (self = [super init]) {
		self.y = self.topBound;
		
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
	}
	return self;
}

-(void)rotated {
	
	CGPoint adjustedCoords = [self adjustCoordsX:lastX Y:lastY];
	lastX = adjustedCoords.x;
	lastY = adjustedCoords.y;
	[self scrollToX:self.x y:self.y];
}

-(CGPoint)adjustCoordsX:(float)xCoord Y:(float)yCoord {
	
	if (xCoord > self.leftBound) {
		xCoord = self.leftBound;
	} else if (xCoord < self.rightBound) {
		xCoord = self.rightBound;
	}
	
	if (yCoord > self.topBound) {
		yCoord = self.topBound;
	} else if (yCoord < self.bottomBound) {
		yCoord = self.bottomBound;
	} 
	
	return CGPointMake(xCoord, yCoord);
}

-(void)shiftForX:(float)dx y:(float)dy {

	float newY = self.y + dy;
	float newX = self.x + dx;
	
	CGPoint adjustedCoords = [self adjustCoordsX:newX Y:newY];
	
	[self setPositionX:adjustedCoords.x y:adjustedCoords.y];
}

-(void)scrollToX:(float)targetX y:(float)targetY {
	
	float dx = -(targetX - [FFGame sharedGame].renderer.screenWidth  * 0.5f);
	float dy = -(targetY - [FFGame sharedGame].renderer.screenHeight  * 0.5f);
	[self shiftForX:dx y:dy];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"MapMoved" object:self];
}

-(void)savePosition {
	lastX = self.x;
	lastY = self.y;
}

-(void)loadPosition {
	self.x = lastX;
	self.y = lastY;
}

-(void)hideIn:(FFGenericRenderer *)renderer {
	[super hideIn:renderer];
}

-(void)createBackgroundFromTexture:(FFTexture*)texture {
	FFSprite* background = [FFSprite spriteWithTexture:texture];
	background.x = background.width * 0.5f;
	background.y = background.height * 0.5f;
	[self addChild:background];
}

#pragma mark bounds

-(float)leftBound {
	return 0.0f;
}

-(float)topBound {
	return 65.0f;
}

-(float)bottomBound {
	return (-(HEIGHT - [FFGame sharedGame].renderer.screenHeight + [GameUI sharedUI].textPanel.height));
}

-(float)rightBound {
	return (-(WIDTH - [FFGame sharedGame].renderer.screenWidth));
}

-(void)dealloc {
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[super dealloc];
}
@end

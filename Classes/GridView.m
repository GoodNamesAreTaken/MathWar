//
//  GridView.m
//  MathWars
//
//  Created by SwinX on 19.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "GridView.h"
#import "FFGame.h"

@interface GridView(Private)

-(int)xPosForItem:(FFView*)item atX:(int)cellX;
-(int)yPosForItem:(FFView*)item atY:(int)cellY;

@end


@implementation GridView

-(id)initWithCellsPerX:(int)xCount andCellsPerY:(int)yCount {
	if (self = [super init]) {
		
		items = [[NSMutableArray alloc] init];
		
		cellsPerX = xCount;
		cellsPerY = yCount;
		
		usedCells = (BOOL**)malloc(cellsPerX * sizeof(BOOL*)); 
		for (int i=0; i<cellsPerX; i++) {
			usedCells[i] = (BOOL*)malloc(cellsPerY * sizeof(BOOL));
		}
		
		for (int i=0; i<xCount; i++) {
			for (int j=0; j<yCount; j++) {
				usedCells[i][j] = NO;
			}
		}
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
		[self rotated];
	}
	return self;
}

-(BOOL)addItem:(FFView*)item {
	for (int j=0; j<cellsPerY; j++) {
		 for (int i=0; i<cellsPerX; i++) {
			if (usedCells[i][j] == NO) {
				return [self addItem:item atX:i Y:j];
			}
		}
	}
	return NO;
}

-(BOOL)addItem:(FFView*)item atX:(int)cellX Y:(int)cellY {
	if (cellX < cellsPerX && cellY < cellsPerY && usedCells[cellX][cellY] == NO) {
		usedCells[cellX][cellY] = YES;
		item.x = [self xPosForItem:item atX:cellX];//cellWidth*cellX + cellWidth/2 - item.width/2;
		item.y = [self yPosForItem:item atY:cellY];
		item.layer = 1;
		[self addChild:item];
		[items addObject:item];
		return YES;
	} else {
		return NO;
	}
}

-(int)xPosForItem:(FFView*)item atX:(int)cellX {
	return cellWidth*cellX + cellWidth/2 - item.width/2;
}

-(int)yPosForItem:(FFView*)item atY:(int)cellY {
	return cellHeight*cellY + cellHeight/2 - item.height/2; 
}

-(void)rotated {
	cellWidth = [FFGame sharedGame].renderer.screenWidth / cellsPerX;
	cellHeight = [FFGame sharedGame].renderer.screenHeight / cellsPerY;
	
	for (int i=0; i<cellsPerX; i++) {
		for (int j=0; j<cellsPerY; j++) {
			if (usedCells[i][j]) {
				FFView* item = [items objectAtIndex:cellsPerX*j + i];
				item.x = [self xPosForItem:item atX:i];
				item.y = [self yPosForItem:item atY:j];
			}
		}
	}
	
}

-(void)dealloc {
	
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[items release];
	
	for (int i=0; i<cellsPerX; i++) {
		free(usedCells[i]);
	}
	free(usedCells);
	[super dealloc];
}

@end

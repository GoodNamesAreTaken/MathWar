//
//  GridView.h
//  MathWars
//
//  Created by SwinX on 19.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"


@interface GridView : FFCompositeView {
	int cellsPerX;
	int cellsPerY;
	
	float cellWidth;
	float cellHeight;
	
	BOOL** usedCells;
	
	NSMutableArray* items;
	
}

-(id)initWithCellsPerX:(int)xCount andCellsPerY:(int)yCount;
-(BOOL)addItem:(FFView*)item;
-(BOOL)addItem:(FFView*)item atX:(int)cellX Y:(int)cellY;
-(void)rotated;

@end

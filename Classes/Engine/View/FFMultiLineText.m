//
//  MultiLineText.m
//  SimpleRPG
//
//  Created by Inf on 12.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFMultiLineText.h"

@interface FFMultiLineText(Private)
@property int lineCount;

-(void)pushStringArray:(NSArray*)array;
-(void)shiftLines:(int)count;


-(NSArray*) splitLongLine:(NSString*)line;
-(FFText*)line:(int)number;

@end


@implementation FFMultiLineText

-(id)initWithFont:(FFFont*)textFont blockWidth:(float)blockWidth blockHeight:(float)blockHeight {
	if (self = [super init]) {
		font = [textFont retain];
		width = blockWidth;
		height = blockHeight;
		
		lines = [[NSMutableArray arrayWithCapacity:self.lineCount] retain];
		for (int i=0; i<self.lineCount; i++) {
			FFText* text = [[FFText alloc] initWithFont:font];
			
			[text setColorR:0 G:0 B:0 A:255];
			text.x = 0;
			text.y = i * font.height;
			[self addChild:text];
			[lines addObject:[text autorelease]];
		}
	}
	return self;
}

-(void)addLine:(NSString*)line {
	NSArray* shortLines = [self splitLongLine:line];
	[self pushStringArray:shortLines];
}

-(void)shiftLines:(int)count {
	int bottomLine = lines.count - 1;
	int upLine = count;
	
	for (int i=bottomLine; i >= upLine; i--) {
		[self line:i].label = [self line:i - count].label;
	}
}

-(void)pushStringArray:(NSArray*)array {
	[self shiftLines:array.count];
	for (int i=0; i<array.count; i++) {
		[self line:i].label = [array objectAtIndex:i];
	}
}

-(NSArray*)splitLongLine:(NSString *)line {
	NSString* currentLine = @"";
	NSMutableArray* resultLines = [NSMutableArray array];
	NSArray* words = [line componentsSeparatedByString:@" "];
	
	for (NSString* word in words) {
		NSString* newLine = [currentLine stringByAppendingFormat:@" %@", word];
		if ([font widthOfText:newLine] < width) {
			currentLine = newLine;
		} else {
			[resultLines addObject:currentLine];
			currentLine = word;
		}
	}
	[resultLines addObject:currentLine];
	return resultLines;
}

-(FFText*)line:(int)number {
	return [lines objectAtIndex:number];
}

-(int)lineCount {
	return floorf(height / font.height);
}

-(void)dealloc {
	[font release];
	[lines release];
	[super dealloc];
}

@end

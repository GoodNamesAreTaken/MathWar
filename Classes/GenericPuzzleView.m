//
//  ExcersizePuzzleView.m
//  MathWars
//
//  Created by SwinX on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "GenericPuzzleView.h"
#import "ExcersizePuzzle.h"
#import "FFButton.h"
#import "FFGame.h"
#import "AnswersGenerator.h"




@implementation GenericPuzzleView

-(id)initWithPuzzle:(HumanPuzzle*)puzzle {
	
	if (self = [super initWithPuzzle:puzzle]) {
		
		description.label = puzzle.description;
		uniqueAnswers = [[AnswersGenerator get:ANSWERS_AMOUNT randomAnswersAround:puzzle.rightAnswer] retain];
        
        for (int i=0; i<uniqueAnswers.count; i++) {
            if ([[uniqueAnswers objectAtIndex:i] intValue] == puzzle.rightAnswer) {
                rightAnswerIndex = i;
                break;
            }
        }
		
	}	
	return self;
}

-(void)showButtons {
	
	FFTexture* buttonTexture = [[FFGame sharedGame].renderer loadTexture:@"puzzleButtonNormal.png"];
	
	float xSpacing = (back.width - buttonTexture.width*2) / 3.0f;
	float yStart = task.y + task.height;
	float ySpacing = (self.height - yStart - buttonTexture.height*2) / 3.0f;
	
	for (int row=0; row<2; row++) {
		for (int col=0; col<2; col++) {
			int value = [[uniqueAnswers objectAtIndex:row*2 + col] intValue];
			FFButton* button = [[FFButton alloc] initWithNormalTexture:@"puzzleButtonNormal.png" pressedTexture:@"puzzleButtonPressed.png" andText:[NSString stringWithFormat:@"%d", value]];
			button.layer = 2;
			
			button.x = xSpacing *(row + 1) + row * button.width;
			button.y = yStart + ySpacing * (col + 1) + col * button.height;
			[self addChild:button];
			[answersButtons addObject:[button autorelease]];
			[button.text setColorR:0 G:0 B:0 A:255];
		}
	}
}

-(void)dealloc {
	[uniqueAnswers release];
	[super dealloc];
}
 
@end

//
//  SequencePuzzleView.m
//  MathWars
//
//  Created by Inf on 23.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "SequencePuzzleView.h"
#import "FFGame.h"
#import "FFButton.h"
#import "AnswersGenerator.h"

#define ANSWERS_AMOUNT 4

@implementation SequencePuzzleView

-(id)initWithPuzzle:(SequencePuzzle*)puzzle; {
	
	if (self = [super initWithPuzzle:puzzle]) {
		
		NSArray* uniqueAnswers = [AnswersGenerator get:ANSWERS_AMOUNT randomAnswersAround:puzzle.rightAnswer];
		description.label = puzzle.description;
		float buttonX = 10.0f;
		
		for (int i=0; i<ANSWERS_AMOUNT; i++) {
			FFButton* button = [[FFButton alloc] initWithText:[NSString stringWithFormat:@"%d", [[uniqueAnswers objectAtIndex:i] intValue]]];
			button.layer = 2;
			button.x = buttonX;
			button.y = back.height - button.height - 13.0f;// - button.height * 2.0 + 10;
			buttonX += button.width + 8;
			[self addChild:button];
			[answersButtons addObject:[button autorelease]];
		}
		
	}	
	
	return self;
	
}


-(void)dealloc {
	[super dealloc];
}
@end

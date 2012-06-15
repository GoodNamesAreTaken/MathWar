//
//  ComparePuzzleView.m
//  MathWars
//
//  Created by Inf on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFGame.h"
#import "ComparePuzzleView.h"


@implementation ComparePuzzleView
@synthesize lesserButton, equalButton, greaterButton;

-(id)initWithPuzzle:(HumanPuzzle*) puzzle {
    if  ((self = [super initWithPuzzle:puzzle])) {
        rightAnswerIndex = puzzle.rightAnswer;
    }
    return self;
}

-(void)showButtons {
	lesserButton = [[FFButton alloc] initWithNormalTexture:@"puzzleButtonNormal.png" pressedTexture:@"puzzleButtonPressed.png" andText:@"<"];
	equalButton = [[FFButton alloc] initWithNormalTexture:@"puzzleButtonNormal.png" pressedTexture:@"puzzleButtonPressed.png" andText:@"="];
	greaterButton = [[FFButton alloc] initWithNormalTexture:@"puzzleButtonNormal.png" pressedTexture:@"puzzleButtonPressed.png" andText:@">"];
	
	float xSpacing =( back.width - lesserButton.width*2) / 3.0f;
	float yStart = task.y + task.height;
	float ySpacing = (self.height - yStart - greaterButton.height*2) / 3.0f;
	
	lesserButton.layer = equalButton.layer = greaterButton.layer = 1;
	
	lesserButton.x = xSpacing;
	[lesserButton.text setColorR:0 G:0 B:0 A:255];
	
	greaterButton.x = lesserButton.x + lesserButton.width + xSpacing;
	greaterButton.y = lesserButton.y = yStart + ySpacing;
	[greaterButton.text setColorR:0 G:0 B:0 A:255];
	
	equalButton.x = (back.width - equalButton.width) * 0.5f;
	equalButton.y = greaterButton.y + greaterButton.height + ySpacing;
	[equalButton.text setColorR:0 G:0 B:0 A:255];
	
	[answersButtons addObject:lesserButton];
	[answersButtons addObject:equalButton];
	[answersButtons addObject:greaterButton];
	
	[self addChild:lesserButton];
	[self addChild:equalButton];
	[self addChild:greaterButton];
}

-(void)dealloc {
	[lesserButton release];
	[equalButton release];
	[greaterButton release];
	[super dealloc];
}

@end

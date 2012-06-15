//
//  HumanPuzzleController.m
//  MathWars
//
//  Created by SwinX on 02.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "NumericPuzzleController.h"
#import "ExcersizePuzzle.h"
#import "FFButton.h"

@implementation NumericPuzzleController

-(void)submit:(FFButton*)button {
	
	if (!model.answered) {
		[timer stop];
		[view showRightAnswer];
		[((ExcersizePuzzle*)model) submitAnswer: [button.text.label integerValue]];	
	}

}

-(void)addActionsToButtons {
	for (FFButton* button in view.answersButtons) {
		[button.click addHandler:self andAction:@selector(submit:)];
	}
}

@end

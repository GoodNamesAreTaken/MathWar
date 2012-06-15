//
//  ComparePuzzleController.m
//  MathWars
//
//  Created by Inf on 23.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "ComparePuzzleView.h"
#import "ComparePuzzleController.h"
#import "ComparePuzzle.h"


@implementation ComparePuzzleController

-(void)addActionsToButtons {
	ComparePuzzleView *compareView = (ComparePuzzleView*)view;
	
	[compareView.lesserButton.click addHandler:self andAction:@selector(submitLesser)];
	[compareView.equalButton.click addHandler:self andAction:@selector(submitEqual)];
	[compareView.greaterButton.click addHandler:self andAction:@selector(submitGreater)];
}

-(void)submitLesser {
	[((ComparePuzzle*)model) submitAnswer:MWLesser];
}

-(void)submitEqual {
	[((ComparePuzzle*)model) submitAnswer:MWEqual];
}

-(void)submitGreater {
	[((ComparePuzzle*)model) submitAnswer:MWGreater];
}

@end

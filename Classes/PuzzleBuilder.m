//
//  PuzzleBuilder.m
//  MathWars
//
//  Created by Inf on 05.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "PuzzleBuilder.h"
#import "ExcersizePuzzle.h"
#import "GenericPuzzleView.h"
#import "NumericPuzzleController.h"

#import "ComparePuzzle.h"
#import "ComparePuzzleView.h"
#import "ComparePuzzleController.h"

#import "SequencePuzzle.h"


@implementation PuzzleBuilder

+(id)sharedBuilder {
	static PuzzleBuilder* instance = nil;
	
	@synchronized(self) {
		if (instance == nil) {
			instance = [[PuzzleBuilder alloc] init];
		}
	}
	return instance;
}

-(PuzzleController*)buildViewControllerFromModel:(Puzzle *)puzzle {
	if ([puzzle isKindOfClass:[ExcersizePuzzle class]] || [puzzle isKindOfClass:[SequencePuzzle class]]) {
		ExcersizePuzzle* concretePuzzle = (ExcersizePuzzle*)puzzle;
		GenericPuzzleView* view = [[GenericPuzzleView alloc] initWithPuzzle:concretePuzzle];
		NumericPuzzleController* controller = [[NumericPuzzleController alloc] initWithPuzzle:concretePuzzle andView:[view autorelease]];
		return [controller autorelease];
	} else if ([puzzle isKindOfClass:[ComparePuzzle class]]) {
		ComparePuzzle* concretePuzzle = (ComparePuzzle*)puzzle;
		ComparePuzzleView* view = [[ComparePuzzleView alloc] initWithPuzzle:concretePuzzle];
		ComparePuzzleController* controller = [[ComparePuzzleController alloc] initWithPuzzle:concretePuzzle andView:[view autorelease]];
		return [controller autorelease];
	} 
	return nil;
}

@end

//
//  HumanPuzzle.m
//  MathWars
//
//  Created by SwinX on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "HumanPuzzle.h"
#import "ExcersizePuzzle.h"
#import "ComparePuzzle.h"

@implementation HumanPuzzle

@synthesize description;


+(id)puzzleWithDifficulty:(int)difficulty andCaller:(id<PuzzleObserver>)caller {
	return [[[ComparePuzzle alloc] initWithDelegate:caller andDifficulty:difficulty] autorelease];
}

-(id)initWithDelegate:(id<PuzzleObserver>)puzzleCaller andDifficulty:(int)puzzleDifficulty {

	if (self = [super initWithDelegate:puzzleCaller andDifficulty:puzzleDifficulty]) {
		description = nil;
	}
	return self;
}

-(int)rightAnswer {
	return 0;
}

-(NSString*)taskString {	
	return nil;
}

-(NSString*)answerString {
	return nil;
}

-(NSString*)description {
	
	return description;
	
}

-(void)dealloc {
	
	[description release];
	[super dealloc];
	
}

@end

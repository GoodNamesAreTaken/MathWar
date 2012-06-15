//
//  ArithmeticSequenceGenerator.m
//  MathWars
//
//  Created by Inf on 23.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "ArithmeticSequenceGenerator.h"


@implementation ArithmeticSequenceGenerator

+(id)generator {
	return [[[ArithmeticSequenceGenerator alloc] init] autorelease];
}

-(NSArray*)createSequenceOfLength:(uint32_t)length {
	NSMutableArray* sequence = [NSMutableArray arrayWithCapacity:length];
	
	int32_t elementDifference;
	do {
		elementDifference = -10 + arc4random() % 20;  
	} while (elementDifference == 0);
	
	int32_t first;
	
	if (elementDifference > 0) {
		first = 1 + arc4random() % 99;
	} else {
		int32_t minValue = -elementDifference * length;
		first = minValue + arc4random() % (100 - minValue);
	}
	
	for (int i=0; i< length; i++) {
		[sequence addObject:[NSNumber numberWithInt:first + i*elementDifference]];
	}
	return sequence;
}

@end

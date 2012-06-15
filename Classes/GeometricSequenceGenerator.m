//
//  GeometricSequenceGenerator.m
//  MathWars
//
//  Created by Inf on 24.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "GeometricSequenceGenerator.h"


@implementation GeometricSequenceGenerator

+(id)generator {
	return [[[GeometricSequenceGenerator alloc] init] autorelease];
}

-(NSArray*)createSequenceOfLength:(uint32_t)length {
	NSMutableArray* sequence = [NSMutableArray arrayWithCapacity:length];
	int current = 2 + arc4random() % 8;
	int maxMultiplier = floorf(powf(1000.0f / current, 0.25f));
	maxMultiplier = MAX(3, maxMultiplier);
	
	int multiplier = 2 + arc4random() % (maxMultiplier - 2);
	
	
	for (int i=0; i<length; i++) {
		[sequence addObject:[NSNumber numberWithInt:current]];
		current *= multiplier; 
	}
	
	//Вернем прямую или обратную последовательность
	
	if (arc4random() % 2 == 0) {
		//обратная
		return [[sequence reverseObjectEnumerator] allObjects];
	} else {
		//прямая
		return sequence;
	}
}

@end

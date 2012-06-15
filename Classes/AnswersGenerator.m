//
//  NumbersGenerator.m
//  MathWars
//
//  Created by SwinX on 07.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "AnswersGenerator.h"

#define SHUFFLE_AMOUNT 10

@interface AnswersGenerator(Private)

-(int)getNumberAroudGiven:(int)number;
-(BOOL)isUniqueAnswer:(int)answer;
-(void)shuffleAnswers;

@end

@implementation AnswersGenerator

@synthesize answers;

+(NSArray*)get:(int)amount randomAnswersAround:(int)answer {

	AnswersGenerator* gen = [[[AnswersGenerator alloc] initWithAnswer:answer andAnswersAmount:amount] autorelease];
	return gen.answers;
	
}

-(id)initWithAnswer:(int)answer andAnswersAmount:(int)amount {
		
	if (self = [super init]) {
		rightAnswer = answer;
		answersAmount = amount;
	 	answers = [[NSMutableArray alloc] init];
		[answers addObject:[NSNumber numberWithInt:answer]];
		
		for (int i=0; i<answersAmount-1; i++) {		//answersAmount - 1 т.к. 1 ответ уже есть в массиве как инициализирующий
			[self getNumberAroudGiven:rightAnswer];
		}
		
		[self shuffleAnswers];
		
	} 	
	return self;
	
}

-(int)getNumberAroudGiven:(int)number {
	
	int answer;
	
	do {
		uint8_t sign = arc4random() % 2;
		switch (sign) {
			case 0:
				answer = number + (arc4random() % answersAmount);
				break;
			default:
				answer = number - (arc4random() % answersAmount);
				break;
		}
		
	} while (![self isUniqueAnswer:answer]);
	[answers addObject:[NSNumber numberWithInt:answer]];
	
	return answer;
}

-(BOOL)isUniqueAnswer:(int)answer {
	
	if (answer < 0) {
		return NO;
	}
	
	for (NSNumber* ans in answers) {
		if ([ans intValue] == answer) {
			return NO;
		}
	}
	return YES;
}

-(void)shuffleAnswers {

	for (int i=0; i<SHUFFLE_AMOUNT; i++) {
		int firstIndex = arc4random() % answersAmount;
		int secondIndex = arc4random() % answersAmount;
		
		[answers exchangeObjectAtIndex:firstIndex withObjectAtIndex:secondIndex];
		
	}
	
}

-(void)dealloc {
	[answers release];
	[super dealloc];
}
@end

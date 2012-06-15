//
//  MathExpression.m
//  MathWars
//
//  Created by Inf on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MathExpression.h"


@implementation MathExpression
@synthesize firstOperand, secondOperand, result, sign;

-(id)init {
	
	if (self = [super init]) {
		sign = arc4random() % 4;
		
		switch (sign) {
			case ESPlus:
				firstOperand = (arc4random() % 10) + 1;
				secondOperand = (arc4random() % 10) + 1; 
				result = firstOperand + secondOperand;
				break;
			case ESMinus:
				secondOperand = (arc4random() % 10) + 1; 
				firstOperand = secondOperand + 1 + arc4random() % 9;
				result = firstOperand - secondOperand;
				break;
			case ESMultiple:
				firstOperand = (arc4random() % 9) + 2;
				secondOperand = (arc4random() % 9) + 2; 
				result = firstOperand * secondOperand;
				break;
			case ESDivide:
				result = (arc4random() % 9) + 2;
				secondOperand = (arc4random() % 9) + 2;
				firstOperand = result * secondOperand;
				break;
			default:
				break;
		}
		
	}
	
	return self;
	
}

-(NSString*)stringRepresentation {
	switch (sign) {
		case ESPlus:
			return [NSString stringWithFormat:@"%d + %d", firstOperand, secondOperand];
		case ESMinus:
			return [NSString stringWithFormat:@"%d - %d", firstOperand, secondOperand];
		case ESDivide:
			return [NSString stringWithFormat:@"%d / %d", firstOperand, secondOperand];
		case ESMultiple:
			return [NSString stringWithFormat:@"%d * %d", firstOperand, secondOperand];
	}
	return @"Invalid";
}

@end

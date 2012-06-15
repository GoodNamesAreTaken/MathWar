//
//  MathExpression.h
//  MathWars
//
//  Created by Inf on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _ExpressionSign {
	ESPlus = 0,
	ESMinus,
	ESMultiple,
	ESDivide
}ExpressionSign;

@interface MathExpression : NSObject {
	int firstOperand;
	int secondOperand;
	int result;
	ExpressionSign sign;
}
/**
 Первый операнд
 */
@property(readonly) int firstOperand;

/**
 Второй операнд
 */
@property(readonly) int secondOperand;

/**
 Знак
 */
@property(readonly) ExpressionSign sign;

/**
 Результат выражения
 */
@property(readonly) int result;

/**
 Строковое представление выражения
 */
@property(readonly) NSString* stringRepresentation;



@end

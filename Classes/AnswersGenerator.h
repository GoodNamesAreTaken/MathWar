//
//  NumbersGenerator.h
//  MathWars
//
//  Created by SwinX on 07.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

/**
 Генератор ответов на пазлы.
 
 Генерирует числа в небольшом диапазоне от правильного ответа. Числа уникальные и только положительные.
 */
@interface AnswersGenerator : NSObject {

	int rightAnswer;
	int answersAmount;
	NSMutableArray* answers;
	
}

@property(readonly) NSMutableArray* answers;

/**
 Возвращает массив с ответами на пазл. 
 Возвращаемые ответы содержат правильный ответ на пазлы. Также они перетасованы в случайном порядке.
 
 @param amount количество ответов, которые необходимо сгенерировать (включая 1 правильный)
 @param answer правильный ответ на пазл
 */
+(NSArray*)get:(int)amount randomAnswersAround:(int)answer;
-(id)initWithAnswer:(int)answer andAnswersAmount:(int)amount;

@end

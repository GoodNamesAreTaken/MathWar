//
//  VectorOperations.m
//  MathWars
//
//  Created by SwinX on 09.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "VectorOperations.h"

@implementation VectorOperations

+(Vector)firstVector:(Vector)first plusSecond:(Vector)second {
	Vector vector;
	vector.x = first.x + second.x;
	vector.y = first.y + second.y;
	return vector;
}

+(float)lengthOfVector:(Vector)vector {
	return sqrt((vector.x * vector.x) + (vector.y * vector.y));
}

+(float)squareLengthOfVector:(Vector)vector {
	return (vector.x * vector.x) + (vector.y * vector.y);
}

+(Vector)normalizeVector:(Vector)vector {
	Vector result;
	result.x = vector.x / [VectorOperations lengthOfVector:vector];
	result.y = vector.y / [VectorOperations lengthOfVector:vector];
	return result;
}

@end

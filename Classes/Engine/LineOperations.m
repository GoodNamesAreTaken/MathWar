//
//  lineOperations.m
//  MathWars
//
//  Created by SwinX on 09.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "LineOperations.h"


@implementation LineOperations

+(float)lengthOfX1:(float)x1 X2:(float)x2 Y1:(float)y1 Y2:(float)y2 {
	return sqrt(pow(x2 - x1 ,2) + pow(y2 - y1,2));
}

+(float)interpolationOfFirstPoint:(float)first andSecondPoint:(float)second withStep:(float)step {
	return first * (1.0f - step) + second * step;
}

@end

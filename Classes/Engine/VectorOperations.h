//
//  VectorOperations.h
//  MathWars
//
//  Created by SwinX on 09.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

typedef struct _Vector {
	
	float x;
	float y;
	
}Vector;

@interface VectorOperations : NSObject {

}

+(Vector)firstVector:(Vector)first plusSecond:(Vector)second;
+(float)lengthOfVector:(Vector)vector;
+(Vector)normalizeVector:(Vector)vector;

@end

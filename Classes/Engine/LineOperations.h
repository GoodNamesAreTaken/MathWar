//
//  lineOperations.h
//  MathWars
//
//  Created by SwinX on 09.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

@interface LineOperations : NSObject {

}

+(float)lengthOfX1:(float)x1 X2:(float)x2 Y1:(float)y1 Y2:(float)y2;
+(float)interpolationOfFirstPoint:(float)first andSecondPoint:(float)second withStep:(float)step;

@end

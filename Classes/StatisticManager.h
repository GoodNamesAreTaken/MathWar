//
//  StatisticManager.h
//  MathWars
//
//  Created by SwinX on 16.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//


@interface StatisticManager : NSObject<NSCoding> {	
	double sumAnswerTime;
	int answersAmount;
}

+(StatisticManager*) manager;
-(float)getAnswerTime;
-(void)addAnswerTime:(float)time;
-(void)save;

@end

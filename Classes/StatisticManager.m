//
//  StatisticManager.m
//  MathWars
//
//  Created by SwinX on 16.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "StatisticManager.h"

static StatisticManager* instance = nil;

@interface StatisticManager(Private)

+(id)getInstance;
+(NSString*)savePath;

@end


@implementation StatisticManager

+(StatisticManager*) manager {
	@synchronized(self) {
		if (instance == nil) {
			instance = [[StatisticManager getInstance] retain];
		}
	}
	return instance;
}

+(id)getInstance {
	StatisticManager* manager = [NSKeyedUnarchiver unarchiveObjectWithFile:[StatisticManager savePath]];
	if (!manager) {
		manager = [[[StatisticManager alloc] init] autorelease];
	}
	return manager;
}

-(id)init {
	if (self = [super init]) {
		sumAnswerTime = 2.0f;
		answersAmount = 1;
	}
	
	return self;	
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		sumAnswerTime = [aDecoder decodeFloatForKey:@"sumAnswerTime"];
		answersAmount = [aDecoder decodeIntForKey:@"answersAmount"];
	}
	
	return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeFloat:sumAnswerTime forKey:@"sumAnswerTime"];
	[aCoder encodeInt:answersAmount forKey:@"answersAmount"];
}

-(float)getAnswerTime {
	return sumAnswerTime / answersAmount;
}

-(void)addAnswerTime:(float)time {
 	sumAnswerTime += time;
	answersAmount++;
}

-(void)save {
	[NSKeyedArchiver archiveRootObject:self toFile:[StatisticManager savePath]];	
}

+(NSString*)savePath {
	NSArray* pathes = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* documentsPath = [pathes objectAtIndex:0];
	return [documentsPath stringByAppendingPathComponent:@"puzzleStatistics"];
}

@end

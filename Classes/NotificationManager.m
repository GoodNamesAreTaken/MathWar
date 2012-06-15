//
//  untitled.m
//  MathWars
//
//  Created by SwinX on 29.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#define NOTIFICATIONS_AMOUNT 5

#import "NotificationManager.h"

static NotificationManager* instance = nil;

@implementation NotificationManager

+(NotificationManager*)manager {
	@synchronized(self) {
		if (instance == nil) {
			instance = [[NotificationManager alloc] init];
		}
	}
	return instance;
}

-(id)init {

	if (self = [super init]) {
		slots = (BOOL*)malloc(NOTIFICATIONS_AMOUNT * sizeof(BOOL));
		memset(slots, 0, NOTIFICATIONS_AMOUNT*sizeof(BOOL));
	}
	
	return self;
}

-(int)getSlot {
	for (int i=0; i<NOTIFICATIONS_AMOUNT; i++) {
		if (slots[i]==NO) {
			slots[i] = YES;
			return i;
		}
	}
	return NO_FREE_SLOT;
}

-(void)freeSlot:(int)slot {	
	slots[slot] = NO;
}

-(void)dealloc {
	free(slots);	
	[super dealloc];
}

@end

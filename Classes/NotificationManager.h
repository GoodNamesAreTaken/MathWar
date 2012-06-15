//
//  untitled.h
//  MathWars
//
//  Created by SwinX on 29.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "NotificationController.h"

typedef enum _SlotErrors {
	NO_FREE_SLOT = -1
}SlotErrors;

@interface NotificationManager : NSObject {
	BOOL* slots;
}

+(NotificationManager*)manager;
-(int)getSlot;
-(void)freeSlot:(int)slot;
@end

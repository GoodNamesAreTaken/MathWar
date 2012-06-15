//
//  NotificationController.h
//  MathWars
//
//  Created by SwinX on 28.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFController.h"
#import "NotificationView.h"
#import "FFTimer.h"
#import "FFSound.h"



@interface NotificationController : NSObject<FFController> {
	
	float time;
	FFTimer* timer;
	NotificationView* view;
	
	BOOL hideAfterShow;
	FFSound* sound;

}

@property(readonly) NotificationView* view;

+(void)showNotificationWithText:(NSString*)text andShowingTime:(float)showingTime;
-(id)initWithViewText:(NSString*)_text andViewShowingTime:(float)showingTime;
-(void)viewShown;
-(void)viewHidden;

@end

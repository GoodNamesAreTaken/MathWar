//
//  Notification.h
//  MathWars
//
//  Created by SwinX on 28.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "SlidingView.h"
#import "FFSprite.h"
#import "FFText.h"

typedef enum _NotificationState {
	
	NSShowing = 0,
	NSShown,
	NSHiding,
	NSHidden,
	NSNone
	
}NotificationState;

@interface NotificationView : SlidingView {
	FFSprite* back;
	FFText* text;
	int notificationSlot;
	id delegate;
	NotificationState state;
	
	id<FFAction> slideAction;
}

@property(readonly) int notificationSlot;
@property(readonly) NotificationState state;
@property(retain) id<FFAction> slideAction;

-(id)initWithText:(NSString*)_text andDelegate:(id)_delegate;
-(void)showNotification;
-(void)hideNotification;
-(void)shown;
-(void)hidden;

@end


//
//  NotificationController.m
//  MathWars
//
//  Created by SwinX on 28.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "NotificationController.h"
#import "NotificationManager.h"
#import "FFGame.h"

@interface NotificationController(Private)

-(void)hideNotification;
-(void)checkNotificationState;

@end

@implementation NotificationController

@synthesize view;

+(void)showNotificationWithText:(NSString*)text andShowingTime:(float)showingTime {
	NotificationController* controller = [[[NotificationController alloc] initWithViewText:text andViewShowingTime:showingTime] autorelease];
	if (controller) {
		[[FFGame sharedGame] addController:controller];
	}
}

-(id)initWithViewText:(NSString*)_text andViewShowingTime:(float)showingTime {

	if (self = [super init]) {
		view = [[NotificationView alloc] initWithText:_text andDelegate:self];
		if (!view) {
			[self release];
			return nil;
		}
		time = showingTime;
		view.slideSpeed = 300.0f;
		hideAfterShow = NO;
		sound = [[[FFGame sharedGame].soundManager getSound:@"notify"] retain];
	}
	
	return self;
	
}

-(void)addedToGame {
	[sound play];
	[view showNotification];
}

-(void)removedFromGame {
	[view hide];
}

-(void)endTouchAt:(CGPoint)point {	
	if ([view pointInside:point]) {
		hideAfterShow = YES;
		[self checkNotificationState];
	}
}

-(void)checkNotificationState {		
	if (view.state == NSShown)  {
		[timer stop];
		[timer release];
		timer = nil;
		
		[self hideNotification];
	} 
}

-(void)hideNotification {
	[view hideNotification];
}

-(void)viewShown {
	if (view.state == NSShown) {
		return;
	}
	if (!hideAfterShow)  {
		timer = [[[FFGame sharedGame].timerManager getTimerWithInterval:time andSingleUse:YES] retain];
		[timer.action addHandler:self andAction:@selector(hideNotification)];
		
		
	} else {
		[self hideNotification];
	}

}

-(void)viewHidden {
	if (view.state != NSHidden) {
		[[NotificationManager manager] freeSlot:view.notificationSlot];
		[[FFGame sharedGame] removeController:self];
		
		[timer stop];
		[timer release];
		timer = nil;
		
	}
	
}

-(void)dealloc {
	[sound release];
	[view release];
	[timer release];
	[super dealloc];
}

@end

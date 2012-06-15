//
//  Notification.m
//  MathWars
//
//  Created by SwinX on 28.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "NotificationView.h"
#import "FFGame.h"
#import "NotificationManager.h"

@interface NotificationView(Private)

-(CGPoint)startPosition;
-(CGPoint)endPosition;

@end


@implementation NotificationView

@synthesize notificationSlot, state, slideAction;

-(id)initWithText:(NSString*)_text andDelegate:(id)_delegate {
	
	if (self = [super init]) {
		
		notificationSlot = [[NotificationManager manager] getSlot]; 
		
		if (notificationSlot == NO_FREE_SLOT) {
			[self release];
			return nil;
		}
		
		self.layer = 50;
		delegate = _delegate;
		
		back = [FFSprite spriteWithTextureNamed:@"slider.png"];
		[self addChild:back];
		
		text = [[FFText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont:@"text"]];
		text.label = _text;
		[text setColorR:0 G:0 B:0 A:255];
		text.x = back.x - text.width/2;
		text.y = back.y - text.height/2;
		text.layer = 1;
		[self addChild:text];
		
		state = NSNone;
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
		
	}
	
	return self;
}

-(void)rotated {
	switch (state) {
		case NSShowing:
		case NSShown:
			[self shown];
			break;
		case NSHiding:
		case NSHidden:
			[self hidden];
			break;
		default:
			break;
	}
}

-(void)showNotification {
	state = NSShowing;
	[self show];
	CGPoint start = [self startPosition];
	[self setPositionX:start.x y:start.y];
	self.slideAction = [self slideActionFrom:start To:[self endPosition] withAfterSlideAction:@selector(shown) ofObject:self];
	
	[[FFGame sharedGame].actionManager addAction:self.slideAction];
}

-(void)hideNotification {
	state = NSHiding;
	self.slideAction = [self slideActionFrom:[self endPosition] To:[self startPosition] withAfterSlideAction:@selector(hidden) ofObject:self];
	[[FFGame sharedGame].actionManager addAction:self.slideAction];
}

-(void)hidden {
	[delegate viewHidden];
	state = NSHidden;
	[[FFGame sharedGame].actionManager cancelAction:self.slideAction ];
	self.slideAction = nil;
	[self setPositionX:[self startPosition].x y:self.startPosition.y];
}

-(void)shown {
	[delegate viewShown];
	state = NSShown;
	[[FFGame sharedGame].actionManager cancelAction:self.slideAction ];
	self.slideAction = nil;

	[self setPositionX:self.endPosition.x y:self.endPosition.y];
	
}

-(void)dealloc {	
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	self.slideAction = nil;
	[text release];
	[super dealloc];
}

@end

@implementation NotificationView(Private)

-(CGPoint)startPosition {
	return CGPointMake([FFGame sharedGame].renderer.screenWidth + back.width/2,
					   65 + back.height/2 + notificationSlot * back.height);
}

-(CGPoint)endPosition {
	return CGPointMake([FFGame sharedGame].renderer.screenWidth - back.width/2, 
					   65 + back.height/2 + notificationSlot * back.height);
}

@end


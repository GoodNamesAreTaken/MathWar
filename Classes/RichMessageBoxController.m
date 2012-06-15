//
//  TutorialWindowController.m
//  MathWars
//
//  Created by SwinX on 02.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "RichMessageBoxController.h"
#import "FFGame.h"
#import "GameUI.h"

@implementation RichMessageBoxController

+(void)showWithHeader:(NSString*)header andPicture:(NSString*)picName andText:(NSString*)text {
	[[FFGame sharedGame] addController:[[[RichMessageBoxController alloc] initWithHeader:header andPicture:picName andText:text andAction:nil andHandler:nil] autorelease]];
}

+(void)showWithHeader:(NSString*)header andPicture:(NSString*)picName andText:(NSString*)text andAction:(SEL)_action andHandler:(id)_handler {
	[[FFGame sharedGame] addController:[[[RichMessageBoxController alloc] initWithHeader:header andPicture:picName andText:text andAction:_action andHandler:_handler] autorelease]];
}

-(id)initWithHeader:(NSString*)header andPicture:(NSString*)picName andText:(NSString*)text andAction:(SEL)_action andHandler:(id)_handler {
	if (self = [super init]) {
		
		action = _action;
		handler = [_handler retain];
		view = [[RichMessageBoxView alloc] initWithPicture:picName andHeader:header andText:text];
		[view.button.click addHandler:self andAction:@selector(hideView)];
	}
	return self;
}

-(void)hideView {	
	[[FFGame sharedGame] removeController:self];
	[handler performSelector:action];

}

-(void)addedToGame {
	[GameUI sharedUI].lock.dialogAtScreen = YES;
	[view show];
}

-(void)removedFromGame {
	[GameUI sharedUI].lock.dialogAtScreen = NO;
	[view hide];
}

-(void)dealloc {
	[view release];
	[handler release];
	[super dealloc];
}

@end

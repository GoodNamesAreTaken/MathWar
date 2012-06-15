//
//  TutorialWindowController.h
//  MathWars
//
//  Created by SwinX on 02.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFController.h"
#import "RichMessageBoxView.h"

@interface RichMessageBoxController : NSObject<FFController> {
	RichMessageBoxView* view;
	
	SEL action;
	id handler;
}

+(void)showWithHeader:(NSString*)header andPicture:(NSString*)picName andText:(NSString*)text;
+(void)showWithHeader:(NSString*)header andPicture:(NSString*)picName andText:(NSString*)text andAction:(SEL)_action andHandler:(id)_handler; 
-(id)initWithHeader:(NSString*)header andPicture:(NSString*)picName andText:(NSString*)text andAction:(SEL)_action andHandler:(id)_handler;

@end

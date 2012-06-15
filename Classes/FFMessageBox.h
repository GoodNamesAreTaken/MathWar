//
//  MessageBox.h
//  MathWars
//
//  Created by SwinX on 11.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFButton.h"
#import "FFController.h"
#import "FFMultiLineText.h"
#import "FFSound.h"

typedef enum _MessageBoxType {
	MB_YES_NO = 0,
	MB_OK
}MessageBoxType;

@interface FFMessageBox : FFCompositeView<FFController> {
	FFSprite* back;
	//FFText* text;
	FFMultiLineText* text;
	FFButton* yes;
	FFButton* no;
	
	id handler;
	SEL yesAction;
    SEL noAction;
	FFSound* appearSound;
}

+(void) ofType:(MessageBoxType)type andText:(NSString*)_text andAction:(SEL)_action andHandler:(id)_handler;
+(void) ofType:(MessageBoxType)type andText:(NSString*)_text andYesAction:(SEL)_yesAction andNoAction:(SEL)_noAction andHandler:(id)_handler;
-(id)initWithType:(MessageBoxType)type AndText:(NSString*)_text andYesAction:(SEL)_yesAction andNoAction:(SEL)_noAction andHandler:(id)_handler;

@end

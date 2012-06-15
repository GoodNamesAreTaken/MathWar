//
//  MessageBox.m
//  MathWars
//
//  Created by SwinX on 11.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFMessageBox.h"
#import "FFGame.h"
#import "GameUI.h"

@interface FFMessageBox(Private)

-(void)removeSelf;

@end



@implementation FFMessageBox

+(void) ofType:(MessageBoxType)type andText:(NSString*)_text andAction:(SEL)_action andHandler:(id)_handler {
	//[[FFGame sharedGame] addController:[[[FFMessageBox alloc] initWithType:type AndText:_text andAction:_action andHandler:_handler] autorelease]];
    [[FFGame sharedGame] addController:[[[FFMessageBox alloc] initWithType:type AndText:_text andYesAction:_action andNoAction:nil andHandler:_handler]autorelease]];
}

+(void) ofType:(MessageBoxType)type andText:(NSString*)_text andYesAction:(SEL)_yesAction andNoAction:(SEL)_noAction andHandler:(id)_handler {
        [[FFGame sharedGame] addController:[[[FFMessageBox alloc] initWithType:type AndText:_text andYesAction:_yesAction andNoAction:_noAction andHandler:_handler]autorelease]];
}

-(id)initWithType:(MessageBoxType)type AndText:(NSString*)_text andYesAction:(SEL)_yesAction andNoAction:(SEL)_noAction andHandler:(id)_handler {
	if (self = [super init]) {
		
		handler = _handler;
		yesAction = _yesAction;
        noAction = _noAction;
		
		appearSound = [[[FFGame sharedGame].soundManager getSound:@"notify"] retain];
		
		self.layer = 100;
		
		back = [FFSprite spriteWithTextureNamed:@"billet.png"];
		[self addChild:back];
		text = [[FFMultiLineText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont:@"text"] blockWidth:200 blockHeight:100];
		[text addLine:_text];
		text.x =  -100;
		text.y = -50;
		text.layer = 1;
		[self addChild:text];
		
		self.x = [FFGame sharedGame].renderer.screenWidth * 0.5f;
		self.y = [FFGame sharedGame].renderer.screenHeight * 0.5f;
		
		if (type == MB_YES_NO) {
			yes = [[FFButton alloc] initWithNormalTexture:@"puzzleButtonNormal.png" pressedTexture:@"puzzleButtonPressed.png" andText:@"Yes"];
			[yes.click addHandler:self andAction:@selector(clickAndHide)];
			yes.x = self.width/2 - yes.width;
			yes.y = self.height/2;
			yes.layer = 1;
			[yes.text setColorR:0 G:0 B:0 A:255];
			[self addChild:yes];
			
			no = [[FFButton alloc] initWithNormalTexture:@"puzzleButtonNormal.png" pressedTexture:@"puzzleButtonPressed.png" andText:@"No"];
			no.x = yes.x + no.width;
			no.y = self.height/2;
			no.layer = 1;
			[no.text setColorR:0 G:0 B:0 A:255];
			[no.click addHandler:self andAction:@selector(removeSelf)];
			
			[self addChild:no];
		} else if (type == MB_OK) {
			
			yes = [[FFButton alloc] initWithNormalTexture:@"puzzleButtonNormal.png" pressedTexture:@"puzzleButtonPressed.png" andText:@"OK"];
			[yes.click addHandler:self andAction:@selector(clickAndHide)];
			yes.x = -yes.width/2;
			yes.y = self.height/2;
			yes.layer = 1;
			[yes.text setColorR:0 G:0 B:0 A:255];
			[self addChild:yes];
		}
		
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];

		
	}
	
	return self;
}

-(void)rotated {
	self.x = [FFGame sharedGame].renderer.screenWidth * 0.5f;
	self.y = [FFGame sharedGame].renderer.screenHeight * 0.5f;
}

-(void)clickAndHide {
	[GameUI sharedUI].lock.dialogAtScreen = NO; 
	[handler performSelector:yesAction];
	[[FFGame sharedGame] removeController:self];
}

-(void)removeSelf {
	if (noAction) {
		[handler performSelector:noAction];
	}
	[GameUI sharedUI].lock.dialogAtScreen = NO;
	[[FFGame sharedGame] removeController:self];
}

-(void)addedToGame {
	[appearSound play];
	[GameUI sharedUI].lock.dialogAtScreen = YES; 
	[self show];
}

-(void)removedFromGame {
	[self hide];
}

-(void)dealloc {
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[appearSound release];
	[text release];
	[yes release];
	[no release];
	[super dealloc];
}

@end

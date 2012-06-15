//
//  TutorialWindowView.m
//  MathWars
//
//  Created by SwinX on 01.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "RichMessageBoxView.h"
#import "FFGame.h"


@implementation RichMessageBoxView

@synthesize button;

-(id)initWithPicture:(NSString*)_pic andHeader:(NSString*)_header andText:(NSString*)_text {
	if (self = [super init]) {
		
		self.x = [FFGame sharedGame].renderer.screenWidth * 0.5f;
		self.y = [FFGame sharedGame].renderer.screenHeight * 0.5f;
		self.layer = 100;
		
		back = [FFSprite spriteWithTextureNamed:@"wideBillet.png"];
		[self addChild:back];
		
		header = [[FFText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont:@"captions"]];
		header.label = _header;
		header.x = - header.width/2;
		header.y = - back.height/2 + header.height/2;
		header.layer = 1;
		[header setColorR:0 G:0 B:0 A:255];
		[self addChild:header];
		
		picture = [FFSprite spriteWithTextureNamed:_pic];
		picture.y = header.y + header.height + picture.height * 0.5;
		picture.layer = 1;
		[self addChild:picture];
		
		text = [[FFMultiLineText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont:@"text"] blockWidth:250.0f blockHeight:250.0f];
		[text addLine:_text];
		text.x = - back.width/2 + 25.0f;
		text.y = picture.y + picture.height/2;
		text.layer = 1;
		[self addChild:text];
		
		button = [[FFButton alloc] initWithNormalTexture:@"puzzleButtonNormal.png" pressedTexture:@"puzzleButtonPressed.png" andText:@"OK"];
		[button.text setColorR:0 G:0 B:0 A:255];
		button.x = - button.width/2;
		button.y = back.y + back.height/2 - (button.height + 6.0f);
		button.layer = 1;
		[self addChild:button];
		
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
		
	}	
	return self;
}

-(void)rotated {
	self.x = [FFGame sharedGame].renderer.screenWidth * 0.5f;
	self.y = [FFGame sharedGame].renderer.screenHeight * 0.5f;
}

-(void)dealloc {
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[button release];
	[header release];
	[text release];
	[super dealloc];
}

@end

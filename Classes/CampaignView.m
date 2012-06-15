//
//  CampaignView.m
//  MathWars
//
//  Created by SwinX on 18.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "CampaignView.h"
#import "FFButton.h"
#import "FFGame.h"

#define BUTTONS_PER_X 4
#define BUTTONS_PER_Y 4

@implementation CampaignView

@synthesize buttons;

-(id)initWithCampaign:(Campaign*)campaign {
	if (self = [super initWithCellsPerX:BUTTONS_PER_X andCellsPerY:BUTTONS_PER_Y]) {
		
		buttons = [[NSMutableArray alloc] init];
		 
		background = [FFSprite spriteWithTextureNamed:@"campaignBack$d.png"];
		background.layer = 0;
		[self addChild:background];
		FFButton* button = nil;
		
		
		for (int i=0; i<campaign.missionsOpened; i++) {
			button = [[FFButton alloc] initWithNormalTexture:@"missionNormal$d.png" pressedTexture:@"missionPressed$d.png" 
															andText:[NSString stringWithFormat:@"%d", i+1]];
			button.tag = [NSString stringWithFormat:@"%d",i + 1];
			[button.text setColorR:0 G:0 B:0 A:255];
			[self addItem:button];
			[buttons addObject:[button autorelease]]; 
		} 
		
		for (int i=campaign.missionsOpened; i<campaign.missionsAmount; i++) {
			button = [[FFButton alloc] initWithNormalTexture:@"missionLockedNormal$d.png" pressedTexture:@"missionLockedPressed$d.png" 
															andText:[NSString stringWithFormat:@"%d", i+1]];
			button.tag = [NSString stringWithFormat:@"%d",i];
			[self addItem:button];
			[buttons addObject:[button autorelease]];
		}
		
		cancelButton = [[FFButton alloc] initWithNormalTexture:@"singleNormal.png" pressedTexture:@"singlePressed.png" andDisabledTexture:nil
												 andText:@"Cancel" andSound:@"menuClick"];
		

		cancelButton.layer = 1;
		[self addChild:cancelButton];
		[buttons addObject:[cancelButton autorelease]];
		[self rotated];

	}
	return self;
}

-(void)rotated {
	[super rotated];
	background.x = [FFGame sharedGame].renderer.screenWidth * 0.5f;//background.width * 0.5f;
	background.y = [FFGame sharedGame].renderer.screenHeight * 0.5f;
	
	cancelButton.x = ([FFGame sharedGame].renderer.screenWidth - cancelButton.width) * 0.5f;
	cancelButton.y = [FFGame sharedGame].renderer.screenHeight - cancelButton.height * 1.5f;
}

-(void)dealloc {
	[buttons release];
	[super dealloc];
}

@end

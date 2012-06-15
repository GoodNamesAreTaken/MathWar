//
//  MissionLoadscreen.m
//  MathWars
//
//  Created by SwinX on 03.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MissionPreloaderView.h"
#import "FFSprite.h"
#import "Trigger.h"
#import "FFGame.h"
#import "FFParallelActions.h"
#import "FFActionSequence.h"
#import "Call.h"

@implementation MissionPreloaderView

@synthesize event;

-(id)initWithHint:(NSString*)hint {
	
	if (self = [super init]) {
		
		self.layer = 1000;
		event = [[FFEvent event] retain];
		
		topPart = [[SlidingView alloc] init];
		
		FFSprite* topSprite;
		topSprite = [FFSprite spriteWithTextureNamed:@"missionPreloaderTop$d.png"];
		topSprite.x = topSprite.y = 0;
		[topPart addChild:topSprite];
		topPart.x = [FFGame sharedGame].renderer.screenWidth / 2;
		topPart.y = topSprite.height/2;
		
		topHeight = topSprite.height;

		[self addChild:topPart];
		
		FFSprite* bottomSprite = [FFSprite spriteWithTextureNamed:@"missionPreloaderBottom$d.png"];
		bottomSprite.x = bottomSprite.y = 0;
		
		bottomPart = [[SlidingView alloc] init];
		bottomPart.x = [FFGame sharedGame].renderer.screenWidth / 2;
		bottomPart.y = [FFGame sharedGame].renderer.screenHeight - bottomSprite.height/2;
		
		[bottomPart addChild:bottomSprite];
		
		botHeight = bottomSprite.height;
		
		bulb = [[FFAnimatedSprite alloc] initWithFrameSequence:@"bulbYellow.png", @"bulbRed.png", nil];
		bulb.x = bottomSprite.x;
		
		[bulb playFramesFrom:0 to:1 withDelay:0.3f];
		bulb.layer = 2;
		[bottomPart addChild:bulb];
		
		hintText = [[FFMultiLineText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont:@"text"]
																					 blockWidth:207.0f blockHeight:120.0f];
		[hintText addLine:hint];
		
		hintText.layer = 1;
		hintText.x = -103.0f;
		[bottomPart addChild:hintText];
		
		topPart.y = topHeight/2;
		bottomPart.y = [UIScreen mainScreen].bounds.size.height - botHeight/2;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			bulb.y = -bottomSprite.height*0.5f + bottomSprite.height * 0.25f;
			
			hintText.y = -90.0f;
		} else {
			bulb.y = -bottomSprite.height*0.5f + bottomSprite.height * 0.375f;
			hintText.y = -8.0f;
		}
		[self addChild:bottomPart];
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
		[self rotated];
	}
	return self;
	
}

-(void)rotated {
	topPart.x = [FFGame sharedGame].renderer.screenWidth / 2;
	bottomPart.x = [FFGame sharedGame].renderer.screenWidth / 2;
}

-(void)openMission {
	id<FFAction> topSlide = [topPart slideActionFrom:CGPointMake(topPart.x, topPart.y) To:CGPointMake(topPart.x, -topHeight/2) withAfterSlideAction:nil ofObject:nil];
	id<FFAction> bottomSlide = [bottomPart slideActionFrom:CGPointMake(bottomPart.x, bottomPart.y) To:CGPointMake(bottomPart.x, [FFGame sharedGame].renderer.screenHeight + botHeight/2) withAfterSlideAction:nil ofObject:nil];
	
	FFParallelActions* slide = [[FFParallelActions alloc] initWithActions:topSlide, bottomSlide, nil];
	FFActionSequence* open = [[FFActionSequence alloc] initWithActions:[slide autorelease], [Trigger event:event], nil];
	
	[[FFGame sharedGame].actionManager addAction:[open autorelease]];
}

-(void)missionOpened {
	[event triggerBy:self];
}

-(void)dealloc {
	[topPart release];
	[bottomPart release];
	[hintText release];
	[bulb release];
	[event release];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

@end

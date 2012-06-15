//
//  Game.m
//  Santa
//
//  Created by Inf on 10.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FFGame.h"
#import "StartMenuController.h"
#import "Campaign.h"
#import "FFControl.h"
#import "StatisticManager.h"
#import "UnitHelper.h"

#define FFGameOrienationChangeNotification @"FFGameOrienationChangeNotification"

@interface FFGame(Private)

-(CGPoint)convertTouchToWorld:(CGPoint)touchPoint;

@end


@implementation FFGame
@synthesize renderer;
@synthesize soundManager;
@synthesize timerManager;
@synthesize actionManager;
@synthesize orientation;

+(FFGame*)sharedGame {
	static FFGame* instance = nil;
	@synchronized(self) {
		if (instance == nil) {
			instance = [[FFGame alloc] init];
		}
	}
	return instance;
}

-(id)init {
	if (self = [super init]) {
		renderer = [[FFRenderer alloc] init];
		soundManager = [[FFSoundManager alloc] init];
		timerManager = [[FFTimerManager alloc] init];
		controllers = [[FFList alloc] init];
		
		modelsStorage = [[NSMutableDictionary alloc] init];
		actionManager = [[FFActionManager alloc] init];
	
		lastUpdateTime = CFAbsoluteTimeGetCurrent();
		
	}
	return self;
}

-(void)start {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		
	[soundManager preloadSound:@"defaultClick" fileName:@"defaultClick" fileExt:@"caf"];
	[soundManager preloadSound:@"menuClick" fileName:@"menuClick" fileExt:@"caf"];
	[soundManager preloadSound:@"puzzleWin" fileName:@"puzzleWin" fileExt:@"caf"];
	[soundManager preloadSound:@"puzzleFail" fileName:@"puzzleFail" fileExt:@"caf"];
	[soundManager preloadSound:@"buildWindow" fileName:@"buildWindow" fileExt:@"caf"];
	[soundManager preloadSound:@"preloader" fileName:@"preloader" fileExt:@"caf"];
	[soundManager preloadSound:@"preloaderEnd" fileName:@"preloaderEnd" fileExt:@"caf"];
	[soundManager preloadSound:@"attackTank" fileName:@"attackTank" fileExt:@"caf"];
	[soundManager preloadSound:@"attackGunner" fileName:@"attackGunner" fileExt:@"caf"];
	[soundManager preloadSound:@"attackCanoneer" fileName:@"attackCanoneer" fileExt:@"caf"];
	[soundManager preloadSound:@"attackTitan" fileName:@"attackTitan" fileExt:@"caf"];
	[soundManager preloadSound:@"attackAnnihilator" fileName:@"attackAnnihilator" fileExt:@"caf"];
	[soundManager preloadSound:@"attackProtector" fileName:@"attackProtector" fileExt:@"caf"];
	
	[soundManager preloadSound:@"unitPick" fileName:@"unitPick" fileExt:@"caf"];
	[soundManager preloadSound:@"notify" fileName:@"notify" fileExt:@"caf"];
	[soundManager preloadSound:@"unitPick" fileName:@"unitPick" fileExt:@"caf"];
	[soundManager preloadSound:@"missionLose" fileName:@"missionLose" fileExt:@"caf"];
	[soundManager preloadSound:@"missionWin" fileName:@"missionWin" fileExt:@"caf"];
	[soundManager preloadSound:@"unitDied" fileName:@"unitDied" fileExt:@"caf"];
	[soundManager preloadSound:@"buildSound" fileName:@"buildSound" fileExt:@"caf"];
	
	[soundManager preloadSound:@"windHowl1" fileName:@"windHowl1" fileExt:@"caf"];
	[soundManager preloadSound:@"windHowl2" fileName:@"windHowl2" fileExt:@"caf"];
	
	for (uint8_t type=MWUnitTank; type<=MWUnitAnnihilator; type++) {
		NSString* soundName = [[UnitHelper sharedHelper] getMoveSoundOf:type];
		[soundManager preloadSound:soundName fileName:soundName fileExt:@"caf"];
	}
	
	Campaign* campaign = [[[Campaign alloc] init] autorelease];
	
	[self registerModel:campaign withName:@"campaign"];
	[self addController:[StartMenuController controller]];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotated) name:UIDeviceOrientationDidChangeNotification object:nil];
	}
	
	
	[pool drain];
}

-(void)update {
	CFTimeInterval elapsed = CFAbsoluteTimeGetCurrent() - lastUpdateTime;
	for (FFListIterator* iter = [controllers firstItem]; iter != nil; iter = [iter nextItem]) {
		if ([iter.object respondsToSelector:@selector(timeElapsed:)]) {
			[iter.object timeElapsed:elapsed];
		}
	}
	
	
	[actionManager doActions:elapsed];
	[timerManager updateTime:elapsed];
	[self resetTimer];
	
}

-(void)addController:(id<FFController>) controller {
	if ([controller respondsToSelector:@selector(addedToGame)]) {
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		[controller addedToGame];
		[pool drain];
	}

	[controllers addItem:controller];
	
}

-(void)removeController:(id<FFController>)controller {
	if ([controller respondsToSelector:@selector(removedFromGame)]) {
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		[controller removedFromGame];
		[pool drain];
	}
	
	FFListIterator* iter = [controllers iteratorOf:controller];
	iter.isDead = YES;
}

-(void)removeAllControllers {
	for (FFListIterator* iter = [controllers firstItem]; iter != nil; iter = [iter nextItem]) {
		iter.isDead = YES;
	}
}

-(void)beginTouchAt:(CGPoint)point {
	point = [self convertTouchPoint:point];
	for (FFListIterator* iter = [controllers firstItem]; iter != nil; iter = [iter nextItem]) {
		if ([iter.object respondsToSelector:@selector(beginTouchAt:)]) {
			NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
			[iter.object beginTouchAt:point];
			[pool drain];
		}
	}
}

-(void)endTouchAt:(CGPoint)point {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	NSMutableArray* others = [NSMutableArray array];
	
	point = [self convertTouchPoint:point];
	
	for (FFListIterator* iter = [controllers firstItem]; iter != nil; iter = [iter nextItem]) {
		if ([iter.object respondsToSelector:@selector(endTouchAt:)]) {
			
			if ([iter.object isKindOfClass:[FFControl class]]) {
				[iter.object endTouchAt:point];
			} else {
				[others addObject:iter.object];
			}
		}
	}
	
	
	for (id<FFController> controller in others) {
		[controller endTouchAt:point];
	}
	[pool drain];
}

-(void)moveTouchFrom:(CGPoint)source to:(CGPoint)destination {
	source = [self convertTouchPoint:source];
	destination = [self convertTouchPoint:destination];
	for (FFListIterator* iter = [controllers firstItem]; iter != nil; iter = [iter nextItem]) {
		if ([iter.object respondsToSelector:@selector(moveTouchFrom:to:)]) {
			[iter.object moveTouchFrom:source to:destination];
		}
	}
}

-(void)registerModel:(id)model withName:(NSString*)name {
	[modelsStorage setValue:model forKey:name];
}

-(void)unregisterModel:(NSString*)name {
	[modelsStorage removeObjectForKey:name];
}


-(id)getModelByName:(NSString*)name {
	return [modelsStorage objectForKey:name];
}


-(void)resetTimer {
	lastUpdateTime = CFAbsoluteTimeGetCurrent();
}

-(CGPoint)convertTouchPoint:(CGPoint)screenPoint {
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return screenPoint;
	}
	
	switch (self.orientation) {
		case UIDeviceOrientationPortrait:
			return screenPoint;
		case UIDeviceOrientationLandscapeRight:
			return CGPointMake(renderer.screenWidth - screenPoint.y, screenPoint.x);
		case UIDeviceOrientationPortraitUpsideDown:
			return CGPointMake(renderer.screenWidth - screenPoint.x, renderer.screenHeight - screenPoint.y);
			break;
		default:
			return CGPointMake(screenPoint.y, renderer.screenHeight - screenPoint.x);
	}
}

-(void)registerOrientationObserver:(id)observer selector:(SEL)selector {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:FFGameOrienationChangeNotification object:nil];
	}
}


-(void)removeFromNotificationCenter:(id)observer {
	[[NSNotificationCenter defaultCenter] removeObserver:observer];
}

-(void)rotated {
	if ([UIDevice currentDevice].orientation  == UIDeviceOrientationFaceUp ||
		[UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown ||
		[UIDevice currentDevice].orientation == UIDeviceOrientationUnknown ||
		[UIDevice currentDevice].orientation == orientation) {
		return;
	}
	
	orientation = [UIDevice currentDevice].orientation;
	switch ([UIDevice currentDevice].orientation) {
		case UIDeviceOrientationPortrait:
			renderer.angle = 0;
			break;
		case UIDeviceOrientationLandscapeRight:
			renderer.angle = 90;
			break;
		case UIDeviceOrientationPortraitUpsideDown:
			renderer.angle = 180;
			break;
		case UIDeviceOrientationLandscapeLeft:
			renderer.angle = 270;
			break;

	}
	
	
	[[NSNotificationCenter defaultCenter] postNotificationName:FFGameOrienationChangeNotification object:nil];
}

-(void)dealloc {
	[renderer release];
	[actionManager release];
	[controllers release];
	[modelsStorage release];
	[backgroundLoop release];
	[super dealloc];
}

@end

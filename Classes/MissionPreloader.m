//
//  MissionPreloader.m
//  MathWars
//
//  Created by SwinX on 11.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MissionPreloader.h"
#import "GameStarter.h"
#import "FFGame.h"

@interface MissionPreloader(Private)

-(void)setUpAndPerformThreadWithAction:(SEL)action andObject:(id)object andFirstArgument:(id)_firstArgument andSecondArgument:(id)_secondArgumen;
-(void)asyncMissionLoad:(MissionPreloader*)sender;

@end


@implementation MissionPreloader

@synthesize loadMissionAction, loadMissionSender, afterLoadAction, afterLoadSender, firstArgument, secondArgument;

+(NSString*)randomHint {
	static NSArray* hints;
	
	@synchronized(hints) {
		if (hints == nil) {
			hints = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Hints" ofType:@"plist"]] retain];
		}
	}
	return [hints objectAtIndex:arc4random() % hints.count];
}

-(void)startTutorialWithAfterStartAction:(SEL)action ofObject:(id)sender {
	loadMissionAction = @selector(startTutorial);
	[self setUpAndPerformThreadWithAction:action andObject:sender andFirstArgument:nil andSecondArgument:nil];
}

-(void)startMissionNamed:(NSString*)name withAfterStartAction:(SEL)action ofObject:(id)sender {
	loadMissionAction = @selector(startMission:);
	
	[self setUpAndPerformThreadWithAction:action andObject:sender andFirstArgument:name andSecondArgument:nil];

}

-(void)startRandomGameWithAfterStartAction:(SEL)action ofObject:(id)sender {
	loadMissionAction = @selector(startRandomGame);
	
	[self setUpAndPerformThreadWithAction:action andObject:sender andFirstArgument:nil andSecondArgument:nil];

}

-(void)startNetworkGameAsServerFromConnection:(GameKitConnection*)connection withAfterStartAction:(SEL)action ofObject:(id)sender {
		
	loadMissionAction = @selector(startNetworkGameAsServerWithConnection:);
	[self setUpAndPerformThreadWithAction:action andObject:sender andFirstArgument:connection andSecondArgument:nil];
	
}

-(void)recieveMap:(MWNetWorkMapParams*)mapParams fromConnection:(GameKitConnection*)connection {// withAfterAction:(SEL)action ofObject:(id)sender {	
	loadMissionAction = @selector(recieveMap:fromConnection:);
	
	self.loadMissionSender = [GameStarter starter];
	self.firstArgument = [NSValue valueWithPointer:mapParams];
	
	[NSThread detachNewThreadSelector:@selector(asyncMissionLoad:) toTarget:self withObject:self];
	
}

-(void)setUpAndPerformThreadWithAction:(SEL)action andObject:(id)object andFirstArgument:(id)_firstArgument andSecondArgument:(id)_secondArgument {
	
	self.loadMissionSender = [GameStarter starter];
	
	self.afterLoadSender = object;
	afterLoadAction = action;
	
	self.firstArgument = _firstArgument;
	self.secondArgument = _secondArgument;
	
	[NSThread detachNewThreadSelector:@selector(asyncMissionLoad:) toTarget:self withObject:self];	
	
}

-(void)asyncMissionLoad:(MissionPreloader*)sender {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1 
												 sharegroup:[FFGame sharedGame].renderer.context.sharegroup];
	
	glFlush();
	
	[EAGLContext setCurrentContext:context];
	[sender.loadMissionSender performSelector:sender.loadMissionAction withObject:sender.firstArgument withObject:sender.secondArgument] ;
	glFlush();
	[EAGLContext setCurrentContext:[FFGame sharedGame].renderer.context];
	[context release];
	[sender.afterLoadSender performSelectorOnMainThread:sender.afterLoadAction withObject:nil waitUntilDone:NO];
	[pool drain];
	
}

-(void)dealloc {
	self.afterLoadSender = nil;
	self.loadMissionSender = nil;

	self.firstArgument = nil;
	self.secondArgument = nil;
	[super dealloc];
}

	
@end

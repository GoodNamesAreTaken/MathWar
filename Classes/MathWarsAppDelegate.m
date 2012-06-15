//
//  MathWarsAppDelegate.m
//  MathWars
//
//  Created by Inf on 19.02.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MathWarsAppDelegate.h"
#import "EAGLView.h"
#import "FFGame.h"

@implementation MathWarsAppDelegate

@synthesize window;
@synthesize glView;

- (void) applicationDidFinishLaunching:(UIApplication *)application
{
	CGRect  rect = [[UIScreen mainScreen] bounds];
    [window setFrame:rect];
	[glView startAnimation];
}

- (void) applicationWillResignActive:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
	[[FFGame sharedGame] resetTimer];
	[glView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[glView stopAnimation];
}

-(void)applicationSignificantTimeChange:(UIApplication *)application {
	[[FFGame sharedGame] resetTimer];
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
	NSLog(@"Not enough memory");
}

- (void) dealloc
{
	[window release];
	[glView release];
	
	[super dealloc];
}

@end

//
//  SantaAppDelegate.m
//  Santa
//
//  Created by Inf on 10.12.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "SantaAppDelegate.h"
#import "EAGLView.h"

@implementation SantaAppDelegate

@synthesize window;
@synthesize glView;

- (void) applicationDidFinishLaunching:(UIApplication *)application
{
	[glView startAnimation];
}

- (void) applicationWillResignActive:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
	[glView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) dealloc
{
	[window release];
	[glView release];
	
	[super dealloc];
}

@end

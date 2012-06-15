//
//  FFUIKitAdapter.m
//  MathWars
//
//  Created by Inf on 22.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFUIKitAdapter.h"


@implementation FFUIKitAdapter

+(id)controllerWithNibName:(NSString*)name {
	return [[[FFUIKitAdapter alloc] initWithNibName:name bundle:nil] autorelease];
}


-(void)addedToGame {
	UIWindow* topWindow = [UIApplication sharedApplication].keyWindow;
	[topWindow addSubview:self.view];
}

-(void)removedFromGame {
	[self.view removeFromSuperview];
}


@end

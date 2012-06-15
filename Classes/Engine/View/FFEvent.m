//
//  Event.m
//  SimpleRPG
//
//  Created by Inf on 26.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFEvent.h"


@implementation FFEvent

+(id)event {
	FFEvent* event = [[FFEvent alloc] init];
	return [event autorelease];
}

-(void)triggerBy:(id)sender {
	[handler performSelector:action withObject:sender];
}

-(void)addHandler:(id)eventHandler andAction:(SEL)handlerAction {
	handler = eventHandler;
	action = handlerAction;
}

@end

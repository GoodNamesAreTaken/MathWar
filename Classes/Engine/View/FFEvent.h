//
//  Event.h
//  SimpleRPG
//
//  Created by Inf on 26.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFControl.h"


@interface FFEvent : NSObject {
	id handler;
	SEL action;
}

+(id)event;
-(void)triggerBy:(id)sender;
-(void)addHandler:(id)eventHandler andAction:(SEL)handlerAction;
@end

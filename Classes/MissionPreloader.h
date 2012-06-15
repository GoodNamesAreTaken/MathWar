//
//  MissionPreloader.h
//  MathWars
//
//  Created by SwinX on 11.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "GameKitConnection.h"

@interface MissionPreloader : NSObject<MessageDelegate> {
	
	SEL loadMissionAction;
	id loadMissionSender;
	
	SEL afterLoadAction;
	id afterLoadSender;
	
	id firstArgument;
	id secondArgument;
	
}

@property(readonly) SEL loadMissionAction;
@property(retain) id loadMissionSender;

@property(assign) SEL afterLoadAction;
@property(assign) id afterLoadSender;

@property(retain) id firstArgument;
@property(retain) id secondArgument;

+(NSString*)randomHint;

-(void)startTutorialWithAfterStartAction:(SEL)action ofObject:(id)sender;
-(void)startMissionNamed:(NSString*)name withAfterStartAction:(SEL)action ofObject:(id)sender;
-(void)startRandomGameWithAfterStartAction:(SEL)action ofObject:(id)sender;
-(void)startNetworkGameAsServerFromConnection:(GameKitConnection*)connection withAfterStartAction:(SEL)action ofObject:(id)sender;



@end

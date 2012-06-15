//
//  Campaign.h
//  MathWars
//
//  Created by SwinX on 18.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

@interface Campaign : NSObject {
	
	NSArray* missionNames;
	
	int missionsAmount;	
	int currentMission;
	
	BOOL playingCampaign;
}

@property int missionsOpened;
@property(readonly) int currentMission;
@property(readonly) int missionsAmount;

@property BOOL playingCampaign;

-(id)init;
-(void)beginMission:(int)mission;
-(void)nextMission;
-(void)campaignComplete;

@end

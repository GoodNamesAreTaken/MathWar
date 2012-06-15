//
//  MissionLoadscreenController.h
//  MathWars
//
//  Created by SwinX on 03.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFController.h"
#import "MissionPreloaderView.h"
#import "FFTimer.h"
#import "MissionPreloader.h"
#import "GameKitConnection.h"
#import "FFSound.h"

@interface MissionPreloaderController : NSObject<FFController> {
		
	MissionPreloader* model;
	MissionPreloaderView* view;
	
	NSString* missionToLoad;
	FFTimer* timer;
	FFSound* backSound;
	
	BOOL missionPreloaded;
	BOOL timerOver;
}

@property(readonly) MissionPreloader* model;

+(void)startTutorial;
+(void)preloadMission:(NSString*)mission;
+(void)preloadRandomGame;

+(void)preloadGameAsServerWithConnection:(GameKitConnection*)connection;
+(void)preloadGameAsClientWithConnection:(GameKitConnection*)connection;
-(void)loadingFinished;

@end

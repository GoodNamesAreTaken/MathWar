//
//  MissionLoadscreen.h
//  MathWars
//
//  Created by SwinX on 03.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFAnimatedSprite.h"
#import "SlidingView.h"
#import "FFEvent.h"
#import "FFMultiLineText.h"

@interface MissionPreloaderView : FFCompositeView {
	SlidingView* topPart;
	SlidingView* bottomPart;
	FFAnimatedSprite* bulb;
	
	FFEvent* event;
	
	FFMultiLineText* hintText;
	
	float topHeight;
	float botHeight;
}

@property(readonly) FFEvent* event;

-(id)initWithHint:(NSString *)hint;
-(void)openMission;
-(void)rotated;

@end

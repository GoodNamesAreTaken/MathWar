//
//  StartMenuView.h
//  MathWars
//
//  Created by Inf on 10.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFButton.h"
#import "FFSprite.h"

@interface StartMenuView : FFCompositeView {
	FFSprite* back;
	FFButton* startCampaign;
	FFButton* startSingleGame;
	FFButton* startMultiplayer;
	FFButton* tutorial;
}

@property(readonly) FFButton* startCampaign;
@property(readonly) FFButton* startSingleGame;
@property(readonly) FFButton* startMultiplayer;
@property(readonly) FFButton* tutorial;

-(void)rotated;

@end

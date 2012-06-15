//
//  CampaignView.h
//  MathWars
//
//  Created by SwinX on 18.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "GridView.h"
#import "FFSprite.h"
#import "Campaign.h"
#import "FFButton.h"

 

@interface CampaignView : GridView {
	NSMutableArray* buttons;
	FFSprite* background;
	FFButton* cancelButton;
}

@property(readonly) NSMutableArray* buttons;


-(id)initWithCampaign:(Campaign*)campaign;
-(void)rotated;
@end

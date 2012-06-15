//
//  OwnIndicator.h
//  MathWars
//
//  Created by SwinX on 01.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFSprite.h"


@interface OwnIndicator : FFCompositeView {
	FFSprite* neutralSprite;
	FFSprite* ourSprite;
	FFSprite* enemySprite;
}

-(id)initWithNeutralTexture:(NSString*)neutralTexture;
-(void)becomeNeutral;
-(void)becomeOur;
-(void)becomeEnemy;

@end

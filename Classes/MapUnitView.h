//
//  MapUnitView.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFSprite.h"
#import "FFCompositeView.h"
#import "Unit.h"
#import "FFActionSequence.h"
#import "ShakingView.h"

/**
 Представление юнита на карте
 
 Отображает и перемещает юнит по карте
 */
@interface MapUnitView : FFCompositeView<UnitObserver> {
	FFSprite* unitImage;
	ShakingView* pickFlag;
}

@property(retain) FFSprite* unitImage;

-(id)initWithTextureNamed:(NSString*)name;

@end

//
//  BuildingView.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFSprite.h"
#import "FFCompositeView.h"
#import "NetworkProtocol.h"
#import "OwnIndicator.h"
#import "AnimatedSpriteWithInterval.h"

/**
 Представление строения
 
 Отвечает за отображение базы и смену цвета при смене владельца
 */
@interface BuildingView : FFCompositeView {
	AnimatedSpriteWithInterval* buildingSprite;
	OwnIndicator* ownIndicator;
}

@property(readonly) float panelX;
@property(readonly) float panelY;
 

+(BuildingView*)viewOfType:(MWMapObjectType)type;

-(id)initWithBuildingTextures:(NSArray*)buildingTextures andPlatformTexture:(NSString*)platformTexture;

/**
 Сменить цвет на нейтральный
 */
-(void)becomeNeutral;

/**
 Сменить цвет на цвет игрока
 */
-(void)becomePlayer;

/**
 Сменить цвет на цвет противника
 */
-(void)becomeEnemy;

@end

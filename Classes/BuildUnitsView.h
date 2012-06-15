//
//  BuildPanel.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "SlidingView.h"
#import "FFButton.h"
#import "BuildUnitView.h"

/**
 Представление понели строительства юнитов
 
 Отображает кнопки для постройки различных юнитов
 */
@interface BuildUnitsView : SlidingView {
	BuildUnitView* buildTankButton;
	BuildUnitView* buildGunnerButton;
	BuildUnitView* buildCanoneerButton;
	BuildUnitView* buildTitanButton;
	BuildUnitView* buildAnnihilatorButton;
	FFSprite* footer;
	FFButton* cancelButton;
}

@property(readonly) float width;
@property(readonly) float height;
@property(readonly) CGPoint endPoint;

/**
 Кнопка постройки танка
 */
@property(readonly) BuildUnitView* buildTankButton;

/**
 Кнопка постройки пулеметчика
 */
@property(readonly) BuildUnitView* buildGunnerButton;

@property(readonly) BuildUnitView* buildCanoneerButton;
@property(readonly) BuildUnitView* buildTitanButton;
@property(readonly) BuildUnitView* buildAnnihilatorButton;

@property(readonly) FFButton* cancelButton;

@end

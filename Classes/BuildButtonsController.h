//
//  BuildPanelController.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Factory.h"
#import "BuildUnitsView.h"
#import "FFController.h"
#import "FFSound.h"

/**
 Контроллер кнопок строительства юнита
 
 Вызывается контроллером базы. Отдает команду строительства юнита
 */
@interface BuildButtonsController : NSObject<FFController> {
	BuildUnitsView* view;
	Factory* model;
	FFSound* fallSound;
	id<FFAction> fallAction;
}
@property(retain) id<FFAction> fallAction;
/**
 Вовзращает объект контроллера
 @param model база, на которой будет производиться строительство
 */
+(id)controllerWithModel:(Factory*)model;

/**
 Создает объект контроллера
 @param factoryModel фабрика, на которой будет производиться строительство
 */
-(id)initWithModel:(Factory*)factoryModel;

-(void)showView;
-(void)fallFinished;
@end

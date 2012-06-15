//
//  PlayerBaseController.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "BuildingController.h"
#import "Factory.h"

/**
 Контроллер базы
 
 Добавляет к контроллеру объекта карты возможность строительства юнитов
 */
@interface FactoryController : BuildingController<FactoryDelegate> {
	
}


@end

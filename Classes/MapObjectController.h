//
//  MapObjectController.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFController.h"
#import "MapObject.h"
#import "FFView.h"
#import "HumanPlayer.h"

/**
 Контроллер объекта карты
 
 При касании игроком объекта карты производит следующие действия:
 1) Если есть активный юнит и объект не содержит юнита игрока, то активный юнит перемещается на объект
 2) Если объект принадлежит игроку и охраняется, то активным юитом становится стражник игрока
 */
@interface MapObjectController : NSObject<FFController> {
	MapObject* model;
	FFView* view;
	HumanPlayer* player;
	BOOL touchStarted;
}

/**
 Возвращает котроллер, созданый с использоваием заданной модели и представления
 
 @param model модель
 @param view представление
 */
+(id)controllerWithModel:(MapObject*)model andView:(FFView*)view;

/**
 Создает котроллер с использоваием заданной модели и представления
 
 @param model модель
 @param view представление
 */
-(id)initWithModel:(MapObject*)object andView:(FFView*)objectView;

/**
 Возвращет TRUE если игрок владеет объектом
 */
-(BOOL)isPlayerOwnsObject;


@end

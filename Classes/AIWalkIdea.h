//
//  AIWalkIdea.h
//  MathWars
//
//  Created by Inf on 04.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Unit.h"
#import "MapObject.h"

/**
 Вариант движения юнита в определенный объект карты
 */
@interface AIWalkIdea : NSObject {
	Unit* unit;
	MapObject* target;
	BOOL possible;
}

/**
 Выигрыш от данного перемещенния
 */
@property(readonly) float cost;

/**
 
 */
@property(readonly) BOOL possible;

@property(readonly) Unit* unit;
@property(readonly) MapObject* target;

/**
 Возвращает объект, созданный используя заданный юнит и целевой объект карты
 @param unit юнит
 @param target целевой объект
 */
+(id)walkIdeaForUnit:(Unit*)unit andTarget:(MapObject*)target;

/**
 Создает объект используя заданный юнит и целевой объект карты
 @param walker юнит
 @param targetObject целевой объект
 */
-(id)initWithUnit:(Unit*)walker andTarget:(MapObject*)targetObject;

/**
 Переместить юнит к целевому объекту
 */
-(void)make;

@end

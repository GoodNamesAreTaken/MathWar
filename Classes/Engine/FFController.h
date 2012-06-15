//
//  Controller.h
//  Santa
//
//  Created by Inf on 10.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


/**
 Протокол контроолера игрового объекта
 
 Задача контроллера - обработка внешних событий, изменение модели и синхронизация модели и представления. Контроллер может подписатся на любое из нижеописанных событий
 */
@protocol FFController<NSObject>

@optional

/**
 Событе,вызываемое при добавлени контроллера в игру. 
 */
-(void)addedToGame;

/**
 Событие, вызываемое при удалении контроллера из игры.
 */
-(void)removedFromGame;

/**
 Событие, вызываемое каждый кадр
 @param elapsed время, прощедщее между двумя вызовами события
 */
-(void)timeElapsed:(CFTimeInterval)elapsed;

/**
 Событие, вызываемое при изменении значений акселерометра
 
 @param acceleration новые значения акселрометра
 */
-(void)accelerate:(UIAcceleration*)acceleration;

/**
 Событие, вызываемое при касании экрана
 
 @param point точка касания
 */
-(void)beginTouchAt:(CGPoint)point;

/**
 Событие, вызываемое по окончанни касания экрана
 
 @param point точка касания
 */
-(void)endTouchAt:(CGPoint)point;

/**
 Событие, вызываемое при перемещении касания
 
 @param source предыдущее положение касания
 @param destination текущая точка касания 
 */
-(void)moveTouchFrom:(CGPoint)source to:(CGPoint)destination;

@end

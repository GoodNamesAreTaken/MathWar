//
//  Game.h
//  Santa
//
//  Created by Inf on 10.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "FFRenderer.h"
#import "FFRenderer.h"
#import "FFController.h"
#import "FFSoundManager.h"
#import "FFSound.h"
#import "FFTimerManager.h"
#import "FFActionManager.h"
#import "FFList.h"

/**
 Главный игровой класс
 
 Главный класс-синглтон, осуществляющий управление всеми объектами игры. Содержит ссылки на такие компонетнты как рендерер, хранилище текстур
 */
@interface FFGame : NSObject {
	FFRenderer* renderer;
	FFSoundManager* soundManager;
	FFTimerManager* timerManager;
	
	FFList* controllers;
	FFSound* backgroundLoop;
	
	CFAbsoluteTime lastUpdateTime;
	
	NSMutableDictionary* modelsStorage;
	
	FFActionManager* actionManager;
	UIDeviceOrientation orientation;
	
}
/**
 Рендерер (графический движок игры)
 */
@property(readonly) FFRenderer* renderer;

@property(readonly) UIDeviceOrientation orientation;

/**
 Звуковой движок игры
 */
@property(readonly) FFSoundManager* soundManager;

/**
 Менеджер таймеров
 */
@property(readonly)FFTimerManager* timerManager;

/**
 Менеджер действий
 */
@property(readonly)FFActionManager* actionManager;


/**
 Возвращяет экземпляр класса. Все обращения к Game должны выполнятся именно через этот метод
 */
+(FFGame*)sharedGame;

/**
 Выполняет добавление начальных игровых элементов, загрузку фона, предзагрузку звуков и фоновой музыки
 */
-(void)start;

/**
 Обновляет все активные контроллеры. Вызываеся на каждом кадре
 @see Controller
 */
-(void)update;

/**
 Добавляет новый контроллер в игру
 */
-(void)addController:(id<FFController>) controller;

/**
 Удаляет контроллер из игры
 */
-(void)removeController:(id<FFController>) controller;

/**
 Удаляет все контроллеры из игры
 */
-(void)removeAllControllers;

/**
 Сообщает контроллерам о начале касания
 @param point точка касания
 @see Controller
 */
-(void)beginTouchAt:(CGPoint)point;

/**
 Сообщает контроллерам об окончании касания
 @param point точка касания
 @see Controller
 */
-(void)endTouchAt:(CGPoint)point;

/**
 Сообщает контроллерам о перемещении касания
 @param source исходная точка касания
 @param destination новое положение касания
 @see Controller
 */
-(void)moveTouchFrom:(CGPoint)source to:(CGPoint)destination;

/**
 Добавление модели в общий доступ
 */
-(void)registerModel:(id)model withName:(NSString*)name;

/**
 Получение модели
 */
-(id)getModelByName:(NSString*)name;

-(void)unregisterModel:(NSString*)name;

-(void)registerOrientationObserver:(id)observer selector:(SEL)selector;

-(void)removeFromNotificationCenter:(id)observer;

-(void)resetTimer;

-(void)rotated;

-(CGPoint)convertTouchPoint:(CGPoint)screenPoint;

@end

//
//  Sound.h
//  Rocket
//
//  Created by Александр on 17.12.09.
//  Copyright 2009 Soulteam. All rights reserved.
//

#import <OpenAL/al.h>
#import <OpenAL/alc.h>

/** Класс представляет единственный звук
 
 С его помощью можно проиграть, остановить и зациклить звук.
 Рекомендуется не инициализировать звук самостоятельно, а получать с помощью функции getSound: класса SoundManager
 @see SoundManager
 */


@interface FFSound : NSObject {
	
	ALuint sourceID;
	
}

/**
Инициализирует звук его источником.
 */
-(id)initWithSourceID:(ALuint) sourceID;

/**
 Проигрывает звук
 */
-(void)play;

/**
 Останавливает звук
 */
-(void)stop;

/**
 Зацикливает звук
 */
-(void)loop;

/**
 Проверяет, остановлен ли звук
 */
-(BOOL)stopped;

@end

//
//  Music.h
//  Santa
//
//  Created by Александр on 20.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FFSound.h"
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

/** Класс представляет аудиоочередь
 
 С его помощью можно проиграть и зациклить аудиоочередь.
 Рекомендуется не инициализировать звук самостоятельно, а получать с помощью функции getQueue: класса SoundManager
 @see SoundManager
 */


@interface FFAudioQueue : FFSound {
	
	NSMutableArray* buffers;
	
}

@property(readonly) NSMutableArray* buffers;

-(id)initWithSourceID:(ALuint)ID;

/**
 Проверяет, проигрались ли все звуки, добавленные в очередь.
 Если да - начинает проигрыш очереди заново.
 */
-(void)update;

/**
 Проигрывает аудиоочередь 1 раз.
 */
-(void)play;

@end

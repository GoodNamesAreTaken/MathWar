//
//  newSoundManager.h
//  Rocket
//
//  Created by Александр on 17.12.09.
//  Copyright 2009 Soulteam. All rights reserved.
//

#import <OpenAL/al.h>
#import <OpenAL/alc.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "FFSound.h"
#import "FFAudioQueue.h"

// afconvert -f caff -d LEI16 {INPUT} {OUTPUT} : WAV -> CAF
// afconvert -f caff -d ima4 audiofile.wav : WAV -> IMA4

/** Базовый класс для звуков
 
	Используется для загрузки звуков, добавления звуков в очереди и возврата инициализированных 
	звуков и звуковых очередей.
 */


@interface FFSoundManager : NSObject {
	
	ALCdevice* device;
	ALCcontext* context;
	
	NSMutableDictionary* soundLibrary;
	NSMutableDictionary* queues;
	
	AVAudioPlayer* BGMPlayer;
	UInt32 otherAudioIsPlaying;
}

@property(readonly) BOOL BGMStopped;

-(void)allowOtherAudio;

/**
Подгружает звук из файла в память
@param theSoundKey ключ(имя), по которому в дальнейшем будут обращаться к подгруженному звуку
@param theFileName имя подгружаемого файла
@param theFileExt расширение подгружаемого файла
*/
-(void) preloadSound:(NSString*)theSoundKey fileName:(NSString*)theFileName fileExt:(NSString*)theFileExt; 

/**
Добавляет звук в очередь.
@param sound имя звука. Звук должен быть заранее подгружен с помощью функции preloadSound
@param queue имя очереди, в которую должен быть добавлен звук
@see preloadSound:fileName:fileExt:
*/
-(void) addSound:(NSString*)sound toQueue:(NSString*)queue;

/**
Возвращает звук, загруженный заранее
@param soundKey имя звука, которым необходимо инициализировать возвращаемый объект
@return готовый и использованию звук. Вызывающий класс должен сохранить звук с помощью retain
@see preloadSound:fileName:fileExt:
@see Sound
*/
-(FFSound*)getSound:(NSString*)soundKey;

/**
Возвращает аудиоочередь, созданную заранее
@param queueKey имя очереди
@return готовая к использованию аудиоочередь. Вызывающий класс должен сохранить аудиоочередь с помощью retain
@see addSound:toQueue:
@see AudioQueue
*/
-(FFAudioQueue*)getQueue:(NSString*)queueKey;

/**
 Проигрывает фоновую
 @param name имя файла, который необходимо проиграть
 */
-(BOOL)playBackgroundMusic:(NSString*)fileName once:(BOOL)onceOrManyTimes;

/**
 Перематывает фоновую музыку на начало
 */
-(void)rewindBGM;

/**
 Останавливает фоновую музыку
 */
-(void)stopBGM;

@end





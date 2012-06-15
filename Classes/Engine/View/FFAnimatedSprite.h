//
//  AnimatedSprite.h
//  Santa
//
//  Created by Inf on 17.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FFSprite.h"
#import "FFTimer.h"

#import "FFEvent.h"

/**
 Двумерная анимированная картинка
 
 Расширенная версия спрайта, умеющая проигрывать заданный кадры текстуры с заданным интервалом. Кадры проигрывается циклически, то есть после последнего кадра вновь идет первый
 */
@interface FFAnimatedSprite : FFSprite {
	uint32_t startFrame;
	uint32_t endFrame;
	uint32_t frame;
	float delay;
	NSMutableArray* frames;
	BOOL paused;

	FFTimer* animationTimer;	
	FFEvent* onSpritesTurnedOver;
}

@property(readonly) int lastFrame;

-(id)init;
-(id)initWithFrameSequence:(NSString*)first, ...;
-(id)initWithArray:(NSArray*)array;
-(void)addSpritesFromArray:(NSArray*)pictureNames;
-(void)playFramesFrom:(uint32_t)start to:(uint32_t)end withDelay:(float)_delay;
-(void)pause;
-(void)play;
-(void)stop;
@end

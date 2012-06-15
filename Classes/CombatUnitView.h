//
//  CombatUnitView.h
//  MathWars
//
//  Created by SwinX on 02.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFAnimatedSprite.h"
#import "FFCompositeView.h"
#import "FFActionSequence.h"
#import "FFText.h"

typedef enum _StatsPos {
	SPRight = 0,
	SPLeft
}StatsPos;

/**
 Представление юнита в бою
 
 Отбражает юнит в бою, проигрывает анимацию смерти, атаки, получения повреждения и простоя
 */
@interface CombatUnitView : FFAnimatedSprite {

	NSDictionary* spriteArrays;
	FFActionSequence* unitActions;

}

//@property(readonly) FFAnimatedSprite* unitView;

/**
 Инициаизурет юнита словарем текстур
 
 @param dictionary словарь, содержащий имена текстур для проигрывания
 */
-(id)initWithSpritesDictionary:(NSDictionary*)dictionary;

/**
 Вернуть анимацию атаки
 */
-(id<FFAction>)attack;

/**
 Вернуть анимацию повреждения
 */
-(id<FFAction>)receiveDamage;

/**
 Вернуть анимацию смерти
 */
-(id<FFAction>)die;

/**
 Проиграть анимацию простоя
 */
-(void)idle;

@end

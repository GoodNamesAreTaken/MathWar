//
//  CombatView.h
//  MathWars
//
//  Created by SwinX on 03.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "CombatUnitView.h"
#import "PuzzleView.h"
#import "Unit.h"
#import "Combat.h"
#import "FFButton.h"
#import "FFParallelActions.h"
#import "FFEvent.h"
#import "FFProgressBar.h"

 /**
 Представление боя
  
  Отображет спрайты обоих участников боя, текущий паззл, сообщения о ходе боя
  */
@interface CombatView : FFCompositeView<CombatObserver> {

	FFSprite* land;
	FFSprite* background;
	CombatUnitView* attackerView;
	CombatUnitView* protectorView;
	PuzzleView* puzzle;
	
	FFEvent* animationsFinished;
	
	FFEvent* attackerStartedMoving;
	FFEvent* attackerFinishedMoving;
	FFEvent* protectorStartedMoving;
	FFEvent* protectorFinishedMoving;
	
	NSString* attackerAtlas;
	NSString* protectorAtlas;
	
	FFProgressBar* attackerHealth;
	FFProgressBar* protectorHealth;
}

@property(nonatomic, readonly) FFEvent* attackerStartedMoving;
@property(nonatomic, readonly) FFEvent* attackerFinishedMoving;
@property(nonatomic, readonly) FFEvent* protectorStartedMoving;
@property(nonatomic, readonly) FFEvent* protectorFinishedMoving;
@property(nonatomic, readonly) FFEvent* animationsFinished;

@property(nonatomic, readonly) CombatUnitView* attackerView;
@property(nonatomic, readonly) CombatUnitView* protectorView;

/**
 Представление паззла
 */
@property(retain) PuzzleView* puzzle;

+(id)combatViewWithUnits:(Unit*)first : (Unit*)second;

/**
 Создает представления, используя модели юнитов-участников
 @param our первый участник
 @param enemy второй участник
 */
-(id)initWithOurUnit:(Unit*)our andEnemyUnit:(Unit*)enemy;
-(void)rotated;

@end

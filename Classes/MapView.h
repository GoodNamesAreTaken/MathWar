//
//  MapView.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFSprite.h"


/**
 Представление карты
 
Отбражает фон, объекты карты, юниты
 */
@interface MapView : FFCompositeView {
	float lastX;
	float lastY;
}

@property(readonly) float rightBound;
@property(readonly) float leftBound;
@property(readonly) float topBound;
@property(readonly) float bottomBound;

/**
 Прокручивает экран таким образом, чтобы заданная точка была в центре
 Координаты точки - абсолютные
 */
-(void)scrollToX:(float)targetX y:(float)targetY;

/**
 Сдвиг карты на заданное значение
 */
-(void)shiftForX:(float)dx y:(float)dy;

/**
 Сохраняет текущую позицию камеры
 */
-(void)savePosition;

/**
 Загружает последнюю сохраненную позицию камеры
 */
-(void)loadPosition;

-(void)createBackgroundFromTexture:(FFTexture*)texture;

-(CGPoint)adjustCoordsX:(float)xCoord Y:(float)yCoord;

@end

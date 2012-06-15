//
//  TextureAtlas.h
//  Rocket
//
//  Created by Inf on 16.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

/**
 Текстурный атлас
 
 Тестурный атлас представляет собой двумерное изобржение, каждый участок которого соответствует определенной текстуре. Используется для оптимизации использования видеопамяти и ускорения рендеринга.
 Максимальный размер атласа - 1024*1024 пикселя на iPhone 2G/3G, 2048*2048 пикселей на iPhone 3GS
 */
@interface FFTextureAtlas : NSObject {
@private
	GLuint textureId;
	uint32_t width;
	uint32_t height;
}

/**
 Идентификатор текстуры
 */
@property(readonly) GLuint textureId;
/**
 Ширина атласа.
 */
@property(readonly) uint32_t width;
/**
 Высота атласа
 */
@property(readonly) uint32_t height;

@property(readonly) float halfTexelWidth;

@property(readonly) float halfTexelHeight;

/**
Конструктор, загружающий атлас из bundle приложения
 
 @param name имя ресурса в bundle
 */
-(id) initWithImageNamed:(NSString*)name;

@end

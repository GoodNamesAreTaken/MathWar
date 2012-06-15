//
//  Texture.h
//  Rocket
//
//  Created by Inf on 06.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <OpenGLES/ES1/gl.h>
#import "Structs.h"

@class FFTextureAtlas;

/**
 2D-текстура
 
 Двумерная текстура - фрагмент атласа
 */
@interface FFTexture : NSObject {
@private
	GLuint textureName;
	
	float width;
	float height;
	
	TexCoords texCoords[4];
	BOOL selfRelease;
}

/**
 Идентификатор текстурного атласа
 */
@property(readonly) GLuint name;

/**
 Ширина всей текстуры
 */
@property(readonly) float width;

/**
 Высота всей текстуры
 */
@property(readonly) float height;

/**
 Текстурные координаты на атласе
 */
@property(readonly) TexCoords* coords;

/**
 Освобождать ли GL-текстуру после удаления объекта. NO, для текстур, создающихся из атласа. YES для текстур, создающихся бутем рендеринга
 */
@property BOOL selfRelease;



+(id)textureWithName:(GLuint)name width:(float)width height:(float)height top:(float)topTexCoord left:(float)leftTexCoord bottom:(float)bottomTexCoord right:(float)rightTexCoord;

-(id)initWithName:(GLuint)name width:(float)texWidth height:(float)texHeight top:(float)topTexCoord left:(float)leftTexCoord bottom:(float)bottomTexCoord right:(float)rightTexture;

@end

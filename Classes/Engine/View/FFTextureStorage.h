//
//  TextureManager.h
//  Rocket
//
//  Created by Inf on 06.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <OpenGLES/ES1/gl.h>
#import "FFTexture.h"

/**
 Менеджер/хранилище текстур
 
 Осуществляет загрузку и храниение текстурных атласов, создание текстур на атласах. Зарузка атласа осуществляется с использованием уникального имени. 
 При попытке повторной загрузки атласа с тем же именем будет возвращена ссылка на ранее загруженный атлас.
 */
@interface FFTextureStorage : NSObject {
@private
	NSMutableDictionary* textures;
	NSMutableDictionary* atlases;
}

/**
 Создает текстуру 
 @param name имя текстуры. Если ребуемый атлас еще не находится в памяти, он будет загружен
 @returns созданная текстура
 */
-(FFTexture*)getTexture:(NSString *)name;
/**
 Возвращает текстурный атлас по его имени. Если атлас еще не находится в памяти, он будет загружен
 */
- (FFTextureAtlas*) getAtlas:(NSString*)name;


-(void)unloadAtlas:(NSString*)name;

@end

//
//  Font.h
//  Rocket
//
//  Created by Inf on 12.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <OpenGLES/ES1/gl.h>
#import "FFTextureAtlas.h"
#import "Structs.h"

/**
 Описание одного символа шрифта в формате AngelCode BMF
 */
@interface FFFontCharacter : NSObject
{
	TexCoords texcoords[4];
	float width;
	float height;
	float xoffset;
	float yoffset;
	float xadvance;
}
/**
 Текстурные координаты символа
 */
@property(readonly) TexCoords* texcoords;

/**
 Ширина символа
 */
@property float width;

/**
 Высота символа
 */
@property float height;
/**
 Смещение символа по оси x
 */
@property float xoffset;
/**
 Смещеие символа по оси y
 */
@property float yoffset;
/**
Смещение по оси x символа, следующего за данным
 */
@property float xadvance;

/**
Конструктор, использующий информацию из бинарного файла BMF
 @param x координата x данного символа в текстурном атласе
 @param y координата y данного символа в текстурном атласе
 @param width ширина символа
 @param height высота символа
 @param texture текстурный атлас, содержащий изображение символа
 */
-(id)initWithX:(int)x y:(int)y width:(int)letterWidth height:(int)letterHeight onTexture:(FFTextureAtlas*)texture;
@end


/**
 Класс, опеспечивающий поддержку шрифтов формата AngelCode BMF
 
 Загружает шрифт из бинарного fnt-файла. Не поддерживает кернинг и описание шрифта в тестовом и XML формате
 */
@interface FFFont : NSObject {
	FFTextureAtlas * texture;
	NSMutableDictionary* letters;
	float height;
}

/**
 Тестурный атлас, содержащий шрифт
 */
@property(readonly) FFTextureAtlas* texture;

/**
 Высота шрифта
 */
@property(readonly) float height; 

/**
 Конструктор, загружающий шрифт из bundle приложения
 
 @param fontTexture текстурный атлас, содержащий изображения символов
 @param name имя fnt-файла в bundle приложения. Расширение fnt автоматически добавляется
 */
- (id) initWithTexture: (FFTextureAtlas*) fontTexture fontName:(NSString*)name;

/**
 Возвращает описание заданного Unicode-символа
 */
- (FFFontCharacter*) getCharacter:(unichar)charCode;

/**
 Возвращает ширину заданного текста в пикселах
 */
-(float)widthOfText:(NSString*)text;

@end

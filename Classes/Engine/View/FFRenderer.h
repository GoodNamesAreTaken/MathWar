//
//  BatchRenderer.h
//  SimpleRPG
//
//  Created by Inf on 16.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFGenericRenderer.h"

#import "Structs.h"
#import "FFTextureStorage.h"
#import "FFFontManager.h"



@interface FFRenderer : FFGenericRenderer {
	
@private
	EAGLContext* context;
	GLuint defaultFramebuffer;
	GLuint colorRenderbuffer;
	
	uint32_t backWidth;
	uint32_t backHeight;
	
	
	FFTextureStorage* textureStorage;
	FFFontManager* fontManager;
	float angle;
}

@property(readonly) uint32_t screenWidth;
@property(readonly) uint32_t screenHeight;
@property float angle;
@property(readonly) EAGLContext* context;

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;


/**
 Выполняет загрузку текстуры из текстурного атласа
 
 Если текстурный атлас еще не загружен в память, то он загружается. Эта оперция может быть медленной, поэтому рекомендуется выполнять ее во время загрузки игры. 
 Если атлас уже находится в памяти, но его повторная загрузка не выполняется и текстура создается на уже существующем атласе
 
 @param name имя текстуры
 @returns ссылка на загруженную текстур 
 */
- (FFTexture*)loadTexture:(NSString*)name;

/**
 Загружает текстурный шрифт формата AngelCode BMF. Чтение из файла с заданным именем происходит лишь единожды. При повторных вызовах функции с тем же именем возвращается экземпляр ранее загруженного шрифта
 
 @param name имя файла-описания шрифта (без расширения)
 */
- (FFFont*) loadFont:(NSString*)name;


-(FFTextureAtlas*)loadAtlas:(NSString*)name;
-(void)unloadAtlas:(NSString*)name;

@end

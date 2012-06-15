//
//  BasicSlider.h
//  SimpleRPG
//
//  Created by Inf on 18.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FFView.h"
#import "FFCBatchNode.h"
#import "FFTexture.h"

/**
 Вертикальный ползунок прогрессбара
 */
@interface FFProgressBar : FFView {
	
	float value;
	float maxValue;
	FFCBatchNode node;
	FFTexture* texture;
}

@property float value;

@property float maxValue;

/**
 Создание ползунка из текстуры
 */
-(id)initWithTextureNamed:(NSString*)textureName;
@end

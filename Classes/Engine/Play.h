//
//  Animate.h
//  MathWars
//
//  Created by SwinX on 08.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFAction.h"
#import "FFAnimatedSprite.h"

@interface Play : NSObject<FFAction> {
	
	NSArray* frames;
	
	FFSprite* sprite;
	uint8_t currentSprite;
	
	CFTimeInterval delay;
	CFTimeInterval elapsed;
	
}
+(id)frames:(NSArray*)_frames ofSprite:(FFSprite*)_sprite withDelay:(CFTimeInterval)_delay;
-(id)initWithSprite:(FFSprite*)_sprite andFrames:(NSArray*)_frames andDelay:(CFTimeInterval)_delay;
@end

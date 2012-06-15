//
//  PlaySound.h
//  MathWars
//
//  Created by SwinX on 16.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFAction.h"
#import "FFSound.h"

@interface PlaySound : NSObject<FFAction> {

	FFSound* sound;
	
}

+(PlaySound*)named:(NSString*)name;
-(id)initWithSoundName:(NSString*)name;
@end

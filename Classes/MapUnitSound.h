//
//  MapUnitSound.h
//  MathWars
//
//  Created by Inf on 01.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFSound.h"
#import "Unit.h"


@interface MapUnitSound : NSObject<UnitObserver> {
	FFSound* moveSound;
	FFSound* pickSound;
}

-(id)initWithType:(uint8_t)type;

@end

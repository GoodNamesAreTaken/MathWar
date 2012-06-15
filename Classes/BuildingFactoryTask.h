//
//  BuildingFactoryTask.h
//  MathWars
//
//  Created by Inf on 30.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "FactoryState.h"


@interface BuildingFactoryTask : NSObject<FactoryState>{
	uint8_t guardianType;
	Factory* factory;
}
@property uint8_t guardianType;

@end

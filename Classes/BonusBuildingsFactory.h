//
//  BounsBuildingsFactory.h
//  MathWars
//
//  Created by SwinX on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Weaponary.h"
#import "NetworkProtocol.h"

#define BONUS_BUILDINGS_COUNT 4

@interface BonusBuildingsFactory : NSObject {

}

+(BonusBuildingsFactory*)sharedFactory;
-(Building*)createBonusBuildingOfType:(MWMapObjectType)type;

@end

//
//  Weaponary.h
//  MathWars
//
//  Created by SwinX on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Building.h"
#import "PlayerObserver.h"

@interface Weaponary : Building<PlayerObserver> {

}

-(void)onOwnerChange:(Player *)newOwner;
-(void)player:(Player*)player assignedUnit:(Unit*)unit;

@end

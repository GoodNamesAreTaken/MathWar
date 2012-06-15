//
//  UpgradeDecision.h
//  MathWars
//
//  Created by Inf on 14.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Decision.h"
#import "Factory.h"


@interface UpgradeDecision : Decision {
	Factory* factory;
}

+(id)atFactory:(Factory*)factory;
-(id)initWithFactory:(Factory*)_factory;

@end

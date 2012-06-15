//
//  BuildDecision.h
//  MathWars
//
//  Created by SwinX on 02.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Decision.h"
#import "Factory.h"

@interface BuildDecision : Decision {
	
	MWUnitType type;
	Factory* location;
	
}

+(BuildDecision*)unitOfType:(MWUnitType)unitType atLocation:(Factory*)buildLocation;
-(id)initWithUnitType:(MWUnitType)unitType andLocation:(Factory*)buildLocation;

@end

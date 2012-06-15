//
//  CaptureTask.m
//  MathWars
//
//  Created by Inf on 06.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "CaptureTask.h"

#import "Base.h"
#import "Factory.h"
#import "Weaponary.h"
#import "Antenna.h"
#import "Repairer.h"
#import "Sheild.h"
#import "MoveDecision.h"
#import "BuildDecision.h"
#import "PathSearch.h"
#import "UpgradeDecision.h"

#define NEAR_BONUS 10.0f
#define UNGUARDED_BONUS 5.0f

@interface CaptureTask(Private)

-(float)computeBasicCost;
-(float)costOfPath:(NSArray*)path;

@end


@implementation CaptureTask
@synthesize performer;

-(id)initWithTarget:(Building*)targetBuilding {
	if (self = [super init]) {
		target = [targetBuilding retain];
		basicCost = [self computeBasicCost];
		
	}
	return self;
}

-(float)cost {
	float cost = basicCost;
	MapObject* startLocation = ([performer isKindOfClass:[Unit class]])? [performer location] : performer;
	NSArray* path = searchPath(startLocation, target);
	
	cost -= [self costOfPath:path];
	
	if ([startLocation.neighbours containsObject:target] && [performer isKindOfClass:[Unit class]]) {
		cost += NEAR_BONUS;
	}
	
	if (target.guardian == nil) {
		cost += UNGUARDED_BONUS;
	}
	return cost;
}

-(float)computeBasicCost {
	if ([target isKindOfClass:[Base class]]) {
		return 7.0f;
	} else if ([target isKindOfClass:[Factory class]]) {
		return 8.0f;
	} else if ([target isKindOfClass:[Weaponary class]]) {
		return 20.0f;
	} else if ([target isKindOfClass:[Sheild class]]) {
		return 20.0f;
	} else if ([target isKindOfClass:[Antenna class]]) {
		return 40.0f;
	} else if ([target isKindOfClass:[Repairer class]]) {
		return 40.0f;
	}
	return 0.0f;
	
}

-(Decision*)makeDecision {
	if ([performer isKindOfClass:[Unit class]]) {
		NSArray* path = searchPath([performer location], target);
		
		if ([[performer location] isKindOfClass:[Factory class]] && [performer canBeUpgraded] && ![(Factory*)[performer location] buildedUnitThisTurn]) {
			return [UpgradeDecision atFactory:(Factory*)[performer location]];
		}
		
		return [MoveDecision move:performer toLocaion:[path objectAtIndex:1]];
	} else if ([performer isKindOfClass:[Factory class]]) {
		int maxAvalibleUnit = MWTotalUnitsCount - 1;
		
		while (![[performer owner].restrictions isUnitAvaliable:maxAvalibleUnit]) {
			maxAvalibleUnit--;
		}
		
		return [BuildDecision unitOfType:arc4random() % maxAvalibleUnit atLocation:performer];
	}
	return nil;
}

-(BOOL)completed {
	return target.owner == [performer owner];
}

-(BOOL)possible {
	if (self.completed) {
		return YES;
	} else if ([performer isKindOfClass:[Unit class]]) {
		return [performer owner].moveCount > 0 && ((Unit*)performer).type != MWUnitBaseProtector;
	} else if ([performer isKindOfClass:[Factory class]]) {
		return ![performer buildedUnitThisTurn] && [performer guardian] == nil;
	}
	return NO;
}

-(id)copyWithZone:(NSZone *)zone {
	CaptureTask* copy =  [[CaptureTask allocWithZone:zone] initWithTarget:target];
	copy.performer = self.performer;
	return copy;
}

-(float)costOfPath:(NSArray *)path {
	if (!path) {
		return INFINITY;
	}
	return path.count;
}



@end

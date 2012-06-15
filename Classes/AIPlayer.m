//
//  AIPlayer.m
//  MathWars
//
//  Created by Inf on 03.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "AIPuzzle.h"
#import "AIPlayer.h"
#import "Factory.h"
#import "MoveDecision.h"
#import "BuildDecision.h"
#import "EndTurnDecision.h"
#import "UpgradeDecision.h"

#import "MapLoader.h"
#import "CaptureTask.h"

NSInteger compareTasks(id<HighLevelTask> first, id<HighLevelTask> second, void* context);
@implementation AIPlayer

@synthesize decision;

-(id)init {
	if (self = [super init]) {
		factories = [[NSMutableArray alloc] init];
		immediateAnswerStrategy = [[ImeddiateAnswerStrategy alloc] init];
		delayedAnswerStrategy = [[DelayedAnswerStrategy alloc] init];
		
		answerStrategy = immediateAnswerStrategy;
	}
	return self;
}

-(void)assignFactory:(Factory *)factory {
	[factories addObject:factory];
	[super assignFactory:factory];
}

-(void)unassignFactory:(Factory *)factory {
	[factories removeObject:factory];
	[super unassignFactory:factory];
}

-(void)endTurn {
	[super endTurn];
	isOurTurn = NO;
}

-(void)tryToUpdgrade {
	for (Factory* factory in factories) {
		if (factory.guardian != nil) {
			[factory upgradeGuardian];
		}
	}
}

-(void)startTurn {
	[super startTurn];
	isOurTurn = YES;
	
	
	[self newDecision];
}

-(NSMutableArray*)findStrategies {
	NSMutableArray* strategies = [NSMutableArray array];
	NSMutableArray* strategiesProto = [NSMutableArray array];//прототипы возможных стратегий
	
	//соберем прототипы стратегий
	for (MapObject* object in [MapLoader sharedLoader].map) {
		if ([object isKindOfClass:[Building class]] && ((Building*)object).owner != self) {
			id<HighLevelTask> taskProto = [[[CaptureTask alloc] initWithTarget:(Building*)object] autorelease];
			[strategiesProto addObject:taskProto];
		}
	}
	
	//добавим в список все возможные стратегии 
	for (id<HighLevelTask> task in strategiesProto) {
		
		// сначала попробуем назначить юниты
		for (Unit* unit in units) {
			task.performer = unit;
			if (task.possible) {
				[strategies addObject:[[task copy] autorelease]];
			}
		}
		
		//теперь - фабрики
		for (Factory* factory in factories) {
			task.performer = factory;
			if (task.possible) {
				[strategies addObject:[[task copy] autorelease]];
			}
		}
			
	}
	return strategies;
}

-(Decision*)findAdditionalDecisions {
	for (Factory* factory in factories) {
		
		if (!factory.buildedUnitThisTurn) {
			
			if (factory.guardian == nil) {
				int maxAvalibleUnit = MWTotalUnitsCount - 1;
				
				while (![self.restrictions isUnitAvaliable:maxAvalibleUnit]) {
					maxAvalibleUnit--;
				}
				
				return [BuildDecision unitOfType:arc4random() % maxAvalibleUnit atLocation:factory];
			} else if ([factory.guardian canBeUpgraded]) {
				return [UpgradeDecision atFactory:factory]; 
			}
		}
	}
	return [EndTurnDecision ofPlayer:self];
}

-(void)bestStrategyDecision {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	NSMutableArray* strategies = [self findStrategies];
	Decision* best;
	
	if (strategies.count == 0) {
		best = [self findAdditionalDecisions];
	} else {
		[strategies sortUsingFunction:compareTasks context:nil];
		best = [[strategies objectAtIndex:0] makeDecision];
	}
	
	self.decision = best;
	self.decision.decisive = self;
	
	[self.decision performSelectorOnMainThread:@selector(performDecision) withObject:nil waitUntilDone:NO];
	
	[pool drain];
}



/**
  Метод, запускающий поиск решения на данном этапе хода AI
 */
-(void)newDecision {
	[NSThread detachNewThreadSelector:@selector(bestStrategyDecision) toTarget:self withObject:nil];
}

-(Puzzle*)createPuzzleOfDifficulty:(uint32_t)difficulty withDelegate:(id<PuzzleObserver>)puzzleDelegate {
	AIPuzzle* puzzle = [[AIPuzzle alloc] initWithDelegate:puzzleDelegate andDifficulty:difficulty];
	
	[answerStrategy answerPuzzle:puzzle];
	return [puzzle autorelease];
}

-(void)startCombat:(Combat *)combat {
	answerStrategy = delayedAnswerStrategy;
	[self readyToNextRoundOfCombat:combat];
}

-(void)finishCombatRound:(Combat *)combat {
	[self readyToNextRoundOfCombat:combat];
}

-(void)finishCombat:(Combat *)combat {
	answerStrategy = immediateAnswerStrategy;		
}

-(void)combatExited {
	if (isOurTurn) {
		[self newDecision];
	}
}

-(void)dealloc {
	[immediateAnswerStrategy release];
	[delayedAnswerStrategy release];
	[decision release];
	[factories release];
	[super dealloc];
}

@end

NSInteger compareTasks(id<HighLevelTask> first, id<HighLevelTask> second, void* context) {
	if (first.cost < second.cost) {
		return NSOrderedDescending;
	} else if (second.cost < first.cost) {
		return NSOrderedAscending;
	}
	return NSOrderedSame;
	
}

//
//  Combat.m
//  MathWars
//
//  Created by Inf on 25.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Combat.h"
#import "Unit.h"
#import "Player.h"
#import "CombatUnitSound.h"

@interface Combat(Private)
@property(readonly) Unit* winner;


-(void)protectorStrike;
-(void)attackerStrike;

-(void)combatFinishedWithWinner:(Unit*)winner;
-(void)nextProtector;
-(void)draw;
-(void)finishRound;

@end


@implementation Combat
@synthesize attacker;

+(id)startCombatBetweenAttacker:(Unit *)attackerUnit andProtectors: (NSArray*)protectors andDelegate:(id<CombatObserver>)delegate {
	Combat* combat = [[[Combat alloc] initWithAttacker:attackerUnit andProtectors:protectors andDelegate:delegate] autorelease];
	
	[combat.attacker.owner startCombat:combat];
	[combat.protector.owner startCombat:combat];
	
	//[combat addObserver:[[[CombatUnitSound alloc] initWithAttacker:combat.attacker.type andProtector:combat.protector.type] autorelease]]; 
	
	return combat;
}

+(id)startCombatBetweenAttacker:(Unit*)attackerUnit andProtector: (Unit*)protectorUnit andDelegate:(id<CombatObserver>)delegate { 
	return [Combat startCombatBetweenAttacker:attackerUnit andProtectors:[NSArray arrayWithObject:protectorUnit] andDelegate:delegate];
}

-(id)initWithAttacker:(Unit*)attackerUnit andProtectors: (NSArray*)protectorsList andDelegate:(id<CombatObserver>)combatDelegate {
	if (self = [super init]) {
		attacker = [attackerUnit retain];
		protectors = [protectorsList retain];
		observers = [[NSMutableArray arrayWithObject:combatDelegate] retain];
		currentProtector = 0;
		puzzleDifficulty = EASY_DIFFICULTY;
	}
	return self;
}

-(void)startRound {
	[attackerPuzzle release];
	attackerPuzzle = nil;
	[protectorPuzzle release];
	protectorPuzzle = nil;
	
	attackerPuzzle = [[attacker.owner createPuzzleOfDifficulty:puzzleDifficulty withDelegate:self] retain];
	protectorPuzzle = [[self.protector.owner createPuzzleOfDifficulty:puzzleDifficulty withDelegate:self] retain];
	
	puzzleDifficulty++;
	
	if (puzzleDifficulty > HARD_DIFFICULTY) {
		puzzleDifficulty = EASY_DIFFICULTY;
	}
}

-(void)attackerStrike {
	[self finishRound];
	self.protector.health -= attacker.attack;
	
	if (self.protector.health > 0) {
		for (id<CombatObserver> observer in observers) {
			if ([observer respondsToSelector:@selector(attacker:strikedProtector:)]) {
				[observer attacker:attacker strikedProtector:self.protector];
				//[observer attackerStrike];
			}
		}
		return;
	}
	
	[self nextProtector];
	if ([self isFinished]) {
		[self combatFinishedWithWinner:self.attacker];
	} 

}

-(void)protectorStrike {
	[self finishRound];
	attacker.health -= self.protector.attack;
	
	if ([self isFinished]) {
		
		[self combatFinishedWithWinner:self.protector];
		
	} else {
		
		for (id<CombatObserver> observer in observers) {
			if ([observer respondsToSelector:@selector(protector:strikedAttacker:)]) {
				//[observer protectorStrike];
				[observer protector:self.protector strikedAttacker:attacker];
			}
		}

	}

}

-(void)puzzleWasSolved:(Puzzle *)puzzle {
	NSLog(@"Puzzle solved: %@", puzzle);
	if (puzzle == attackerPuzzle) {
		if (protectorPuzzle.failed) {
			[self attackerStrike];
		} else if (protectorPuzzle.solved) {
			[self draw];
		} else {
			[protectorPuzzle fail];
		}
	} else {
		if (attackerPuzzle.failed) {
			[self protectorStrike];
		} else if (attackerPuzzle.solved) {
			[self draw];
		} else {
			//Если на паззл еще не был дан ответ, то игрок проиграл
			[attackerPuzzle fail];
		}
	}
}

-(void)puzzleWasFailed:(Puzzle *)puzzle {
	NSLog(@"Puzzle failed: %@", puzzle);
	
	if (puzzle == attackerPuzzle && protectorPuzzle.solved) {
		[self protectorStrike];
	} else if (puzzle == protectorPuzzle && attackerPuzzle.solved) {
		[self attackerStrike];
	} else if (attackerPuzzle.failed && protectorPuzzle.failed) {
		[self draw];
	}
}

-(void)addObserver:(id<CombatObserver>)observer {
	[observers addObject:observer];	
}

-(void)combatFinishedWithWinner:(Unit*)winner {
	[attacker.owner finishCombat:self];
	[self.protector.owner finishCombat:self];
	
	if (winner == attacker) {
		for (id<CombatObserver> observer in observers) {
			if ([observer respondsToSelector:@selector(protectorsBeatenBy:)]) {
				[observer protectorsBeatenBy:attacker];
			}
		}
	} else {
		for (id<CombatObserver> observer in observers) {
			if ([observer respondsToSelector:@selector(attackerDeath)]) {
				[observer attackerDeath];
			}
		}
	}

}

-(BOOL)isFinished {
	return (attacker.health <= 0) || (currentProtector >= protectors.count);
}

-(id<CombatObserver>)delegate {
	return [observers objectAtIndex:0];
}

-(void)combatExited {
	
	for (id<CombatObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(userExitedCombat:withWinner:)]) {
			[observer userExitedCombat:self withWinner:self.winner];
		}
	}
	
	[attacker.owner combatExited];
	[self.protector.owner combatExited];
}

-(Unit*)protector {
	if (![self isFinished]) {
		return [protectors objectAtIndex:currentProtector];
	}
	return [protectors lastObject];
}

-(void)nextProtector {
	Unit* oldProtector = self.protector;
	currentProtector++;
	if (![self isFinished]) {
		for (id<CombatObserver> observer in observers) {
			if ([observer respondsToSelector:@selector(protectorChangedFrom:to:)]) {
				[observer protectorChangedFrom:oldProtector to:self.protector];
			}
		}
	}
}

-(Unit*)winner {
	if (attacker.health <= 0) {
		return self.protector;
	} else if (self.protector.health <= 0) {
		return attacker;
	}
	return nil;
}

-(void)draw {
	[self finishRound];
	for (id<CombatObserver> observer in observers) {
		if ([observer respondsToSelector:@selector(draw)]) {
			[observer draw];
		}
	}
}

-(void)playerReady:(Player*)player {
	if (player == attacker.owner) {
		attackerReady = YES;
	} else {
		protectorReady = YES;
	}
	
	if (attackerReady && protectorReady) {
		[self startRound];
	}

}

-(void)finishRound {
	attackerReady = protectorReady = NO;
	
	[attacker.owner finishCombatRound:self];
	[self.protector.owner finishCombatRound:self];
}

-(void)dealloc {
	[attacker release];
	[protectors release];
	[attackerPuzzle release];
	[protectorPuzzle release];
	[observers release];
	[super dealloc];
}

@end

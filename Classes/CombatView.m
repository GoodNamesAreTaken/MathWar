//
//  CombatView.m
//  MathWars
//
//  Created by SwinX on 03.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "CombatView.h"
#import "FFGame.h"
#import "UnitHelper.h"
#import "GameUI.h"

#import "FFParallelActions.h"
#import "Move.h"
#import "Trigger.h"
#import "Call.h"

#define UNITS_SPEED 100.0f

@interface CombatView(Private)

-(void)addExitButton;

-(void)preloadAtlases:(id)sender;
-(void)setupUnits:(id)sender;

-(void)asyncProtectorChange:(Unit*)protector;
-(void)setupProtector:(Unit*)protector;
-(void)animateNewProtector:(Unit*)protector;

@end



@implementation CombatView
@synthesize puzzle, animationsFinished;
@synthesize attackerStartedMoving, attackerFinishedMoving, protectorStartedMoving, protectorFinishedMoving;
@synthesize attackerView, protectorView;

+(id)combatViewWithUnits:(Unit*)first : (Unit*)second {
	return [[[CombatView alloc] initWithOurUnit:first andEnemyUnit:second] autorelease];
}

-(id)initWithOurUnit:(Unit*)first andEnemyUnit:(Unit*)second{
	
	if (self = [super init]) {
		self.x = [FFGame sharedGame].renderer.screenWidth / 2;
		self.y = [FFGame sharedGame].renderer.screenHeight / 2;
		self.layer = 6;
		
		attackerAtlas = [[UnitHelper sharedHelper] getCombatAtlasOf:first.type andUnitLevel:first.upgrades];
		protectorAtlas = [[UnitHelper sharedHelper] getCombatAtlasOf:second.type andUnitLevel:second.upgrades];
		
		animationsFinished = [[FFEvent event] retain];
		
		attackerStartedMoving = [[FFEvent event] retain];
		attackerFinishedMoving = [[FFEvent event] retain];
		protectorStartedMoving = [[FFEvent event] retain];
		protectorFinishedMoving = [[FFEvent event] retain];
		
		background = [FFSprite spriteWithTextureNamed:@"combatBack$d.png"];
		background.layer = 2;
		//background.y = 65; //ширина верхней плашки
		
		land = [FFSprite spriteWithTextureNamed:@"combatLand$d.png"];
		land.y =  background.y + (land.height - background.height) * 0.5f;//65 + land.height*0.5f;
		
		attackerHealth = [[FFProgressBar alloc] initWithTextureNamed:@"healthbar.png"];
		attackerHealth.layer = 3;
		attackerHealth.maxValue = first.maxHealth;
		attackerHealth.value = first.health;
		attackerHealth.x = land.x - land.width*0.5f + 5.0f;
		attackerHealth.y = land.y + land.height * 0.5f - attackerHealth.height;
		
		protectorHealth = [[FFProgressBar alloc] initWithTextureNamed:@"healthbar.png"];
		protectorHealth.layer = 3;
		protectorHealth.maxValue = second.maxHealth;
		protectorHealth.value = second.health;
		protectorHealth.x = land.x + land.width/2 -protectorHealth.width - 5.0f;
		protectorHealth.y = land.y + land.height * 0.5f - protectorHealth.height;
		
		[self addChild:background];
		[self addChild:land];
		[self addChild:attackerHealth];
		[self addChild:protectorHealth];
		
		//асинхронная загрузка спрайтов
		[NSThread detachNewThreadSelector:@selector(preloadAtlases:) 
								 toTarget:self 
								 withObject:[NSDictionary dictionaryWithObjectsAndKeys:first, @"attacker", second, @"protector", nil]];
		
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
		[self rotated];
	}
	return self;	
}

-(void)preloadAtlases:(id)sender {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1 
												 sharegroup:[FFGame sharedGame].renderer.context.sharegroup];
	
	[EAGLContext setCurrentContext:context];
	
	[[FFGame sharedGame].renderer loadAtlas:attackerAtlas];
	
	if (![attackerAtlas isEqualToString:protectorAtlas]) {
		[[FFGame sharedGame].renderer loadAtlas:protectorAtlas];
	}
	

	[context release];
	
	[self performSelectorOnMainThread:@selector(setupUnits:) withObject:sender waitUntilDone:NO];
	[pool drain];
}

-(void)asyncProtectorChange:(Unit *)protector {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1 
												 sharegroup:[FFGame sharedGame].renderer.context.sharegroup];
	
	[EAGLContext setCurrentContext:context];

	protectorAtlas = [[UnitHelper sharedHelper] getCombatAtlasOf:protector.type andUnitLevel:protector.upgrades];

	if (![attackerAtlas isEqualToString:protectorAtlas]) {
		[[FFGame sharedGame].renderer loadAtlas:protectorAtlas];
	}
	
	[context release];
	
	[self performSelectorOnMainThread:@selector(animateNewProtector:) withObject:protector waitUntilDone:NO];
	[pool drain];
}

-(void)setPuzzle:(PuzzleView *)puzzleView {
	if (puzzle != puzzleView) {

		[self removeChild:puzzle];
		[puzzle release];
		
		puzzle = [puzzleView retain];
		puzzle.layer = self.absoluteLayer + 10;
		
		//puzzle.x -= self.x;
		//puzzle.y -= self.y;
//		puzzle.x = [FFGame sharedGame].renderer.screenWidth - puzzleView.width * 0.5f;
//		puzzle.y = land.y + land.height/2 + puzzleView.height/2;
	
		//[self addChild:puzzle];
		
	}
}

-(void)setupUnits:(id)sender {
	
	Unit* attacker = [sender valueForKey:@"attacker"];
	Unit* protector = [sender valueForKey:@"protector"];
	
	attackerView = [[[UnitHelper sharedHelper] getCombatViewOf:attacker.type And:attacker.upgrades] retain];//[CombatUnitView combatUnitViewWithType:our.type];
	attackerView.x = land.x - land.width/2 - attackerView.width *0.5f;
	attackerView.y = land.y + land.height/2 - attackerView.height/2;
	attackerView.layer = 1;
	
		
	[self addChild:attackerView];
	
	[self setupProtector: protector];
	
	FFParallelActions* moveUnitsAction = [[FFParallelActions alloc] initWithActions:
											[Move view:attackerView to:CGPointMake(land.x - land.width/2 + protectorView.width/2, land.y + land.height/2 - attackerView.height/2) withSpeed:UNITS_SPEED],
											[Move view:protectorView to:CGPointMake(land.x + land.width/2 - protectorView.width/2, land.y + land.height/2 - protectorView.height/2) withSpeed:UNITS_SPEED],
											nil
										  ];
	
	FFActionSequence* moveAndTrigger = [[FFActionSequence alloc] initWithActions:
											[Trigger event:attackerStartedMoving],
											[Trigger event:protectorStartedMoving],
											[moveUnitsAction autorelease],
											[Trigger event:animationsFinished],
											[Trigger event:attackerFinishedMoving],
											[Trigger event:protectorFinishedMoving],										
											nil
										];
	
	[[FFGame sharedGame].actionManager addAction:[moveAndTrigger autorelease]];

}

-(void)draw {
	[[FFGame sharedGame].actionManager addAction:[Trigger event:animationsFinished]];
}


-(void)attacker:(Unit*)_attacker strikedProtector:(Unit*)_protector {
	protectorHealth.value = _protector.health;
	FFParallelActions* animation = [[[FFParallelActions alloc] initWithActions:
									 [attackerView attack],
									 [protectorView receiveDamage],
									 nil
									 ] autorelease];
	
	[[FFGame sharedGame].actionManager addAction:
	 [[[FFActionSequence alloc] initWithActions:animation, [Trigger event:self.animationsFinished], nil] autorelease]
	 ];
	
}

-(void)protector:(Unit*)_protector strikedAttacker:(Unit*)_attacker {
	
	attackerHealth.value = _attacker.health;
	FFParallelActions* animation = [[[FFParallelActions alloc] initWithActions:
									 [attackerView receiveDamage],
									 [protectorView attack],
									 nil
									 ] autorelease];
	
	[[FFGame sharedGame].actionManager addAction:
		[[[FFActionSequence alloc] initWithActions:animation, [Trigger event:self.animationsFinished], nil] autorelease]
	];

}

-(void)attackerDeath {
	attackerHealth.value = 0;
	FFParallelActions* animation = [[[FFParallelActions alloc] initWithActions:
									 [attackerView die],
									 [protectorView attack],
									 nil
									 ] autorelease];
	
	[[FFGame sharedGame].actionManager addAction:
	 [[[FFActionSequence alloc] initWithActions:
									animation, 
									[Trigger event:self.animationsFinished], 
									nil] autorelease]
	 ];
}

-(void)protectorsBeatenBy:(Unit*)attacker {
	protectorHealth.value = 0;
	FFParallelActions* animation = [[[FFParallelActions alloc] initWithActions:
									 [attackerView attack],
									 [protectorView die],
									 nil
									 ] autorelease];
	
	[[FFGame sharedGame].actionManager addAction:
	 [[[FFActionSequence alloc] initWithActions:
	   animation, 
	   [Trigger event:self.animationsFinished], 
	   nil] autorelease]
	 ];
}

-(void)setupProtector:(Unit *)newProtector {
	
	[protectorView hide];
	[protectorView release];
	
	protectorView = [[[UnitHelper sharedHelper] getCombatViewOf:newProtector.type And:newProtector.upgrades] retain];
	protectorView.x = land.x + land.width/2 + protectorView.width/2;//background.width + protectorView.width*0.5f;//230.0f;
	protectorView.y = land.y + land.height/2 - protectorView.height/2;//120.0f;
	protectorView.layer = 1;
	protectorView.mirror = YES;
	
	
	[self addChild:protectorView];
}

-(void)animateNewProtector:(Unit*)protector {
	[self setupProtector:protector];
	
	
	FFActionSequence* moveAndTrigger = [[FFActionSequence alloc] initWithActions:
															[Trigger event:protectorStartedMoving],
															[Move view:protectorView to:CGPointMake(land.x + land.width/2 - protectorView.width/2
																									, land.y + land.height/2 - protectorView.height/2) withSpeed:UNITS_SPEED],
															[Trigger event:animationsFinished],
															[Trigger event:protectorFinishedMoving],
															nil];
	[[FFGame sharedGame].actionManager addAction:[moveAndTrigger autorelease]];
}

-(void)userExitedCombat:(Combat*)combat withWinner:(Unit*)winner {
	[[FFGame sharedGame].renderer unloadAtlas:attackerAtlas];
	[[FFGame sharedGame].renderer unloadAtlas:protectorAtlas];
}

-(void)replaceProtectorView:(Unit*)newProtector {
	[self removeChild:protectorView];
	if (![attackerAtlas isEqualToString:protectorAtlas]) {
		[[FFGame sharedGame].renderer unloadAtlas:protectorAtlas];
	}
	protectorHealth.maxValue = newProtector.maxHealth;
	protectorHealth.value = newProtector.health;
	
	[NSThread detachNewThreadSelector:@selector(asyncProtectorChange:) toTarget:self withObject:newProtector];
}

-(void)protectorChangedFrom:(Unit*)oldProtector to:(Unit *)newProtector {
	protectorHealth.value = 0;
	FFParallelActions* animations = [[FFParallelActions alloc] initWithActions:
									 [protectorView die],
									 [attackerView attack],
									 nil
									 ];
	
	FFActionSequence* sequence = [[FFActionSequence alloc] initWithActions:[animations autorelease], 
																		   [Call selector:@selector(replaceProtectorView:) ofObject:self withParam:newProtector],
																			nil];
	
	[[FFGame sharedGame].actionManager addAction:[sequence autorelease]];
	
}

-(void)rotated {
	
	self.x = [FFGame sharedGame].renderer.screenWidth * 0.5f;
	self.y = [FFGame sharedGame].renderer.screenHeight * 0.5f;
	
}

-(void)dealloc {
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[attackerStartedMoving release];
	[protectorStartedMoving release];
	[attackerFinishedMoving release];
	[protectorFinishedMoving release];

	[attackerHealth release];
	[protectorHealth release];
	
	[animationsFinished release];
	[attackerView release];
	[protectorView release];
	[puzzle release];	
	[super dealloc];
	
}

@end

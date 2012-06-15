//
//  Obstacle.h
//  MathWars
//
//  Created by SwinX on 09.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MapObject.h"
#import "Puzzle.h"

@interface Obstacle : MapObject<PuzzleObserver> {
	uint8_t puzzleDifficulty;
	
	//юнит-кандидат, который пытается преодолеть препятствие
	Unit* candiadate;
}

-(id)initWithPuzzleDifficulty:(uint8_t)difficulty;
-(void)negativeEffectOn:(Unit*)unit;
-(void)positiveEffectOn:(Unit*)unit;

@end

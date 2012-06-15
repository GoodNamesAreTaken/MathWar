//
//  PuzzleView.m
//  MathWars
//
//  Created by SwinX on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "PuzzleView.h"
#import "FFGame.h"
#import "GameUI.h"

@implementation PuzzleView

@synthesize answersButtons, finished, rightAnswerButton;

-(id)initWithPuzzle:(HumanPuzzle*)puzzle {
	
	if (self = [super init]) {
		self.layer = 4;
		
		clock = [FFSprite spriteWithTextureNamed:@"clock.png"];
		clock.y = clock.height * 0.5f;
		clock.layer = 1;
		

		
		back = [[FFSprite spriteWithTextureNamed:@"puzzleBack$d.png"] retain];
		back.layer = 0;
		back.x = back.width * 0.5f;
		back.y = back.height * 0.5f + clock.y + clock.height * 0.5f;
		
		clock.x = back.width * 0.5f;
		
		[self addChild:back];
		[self addChild:clock];
		
		answersButtons = [[NSMutableArray alloc] init];
		
		time = [[FFText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont:@"captions"]];
		[time setColorR:0 G:0 B:0 A:255];
		time.x = clock.x - time.width*0.5f;
		time.y = clock.y - time.height * 0.5f;
		time.layer = 2;
		[self addChild:time];
		
		description = [[FFText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont: @"captions"]];
		description.y = back.y - back.height * 0.5f + 5;
		description.layer = 1;
		[description setColorR:0 G:0 B:0 A:255];
		[self addChild:description];
		
		task = [[FFText alloc] initWithFont:[[FFGame sharedGame].renderer loadFont:@"captions"]];
		task.layer = 1;
		task.label = [puzzle taskString];
		task.x = back.x - task.width * 0.5f;
		task.y = description.y + description.height + 5.0f;

		[task setColorR:0 G:0 B:0 A:255];

		[self addChild:task];
		
		rightAnswer = [[puzzle answerString] retain];
		finished = [[FFEvent event] retain];
		
		[[FFGame sharedGame] registerOrientationObserver:self selector:@selector(rotated)];
		
	}
	return self;
	
}

-(void)rotated {
	CGPoint end = self.endPoint;
	
	[self setPositionX:end.x y:end.y];
}

-(CGPoint)endPoint {
	return CGPointMake(([FFGame sharedGame].renderer.screenWidth - self.width) * 0.5f, 
						[FFGame sharedGame].renderer.screenHeight - [GameUI sharedUI].textPanel.height - self.height);
}

-(void)setDescription:(NSString*)newDescription; {
	description.label = newDescription;
	description.x = back.x - description.width * 0.5f;
}

-(void)setRemainigTime:(float)newTime {
	
	time.label = [NSString stringWithFormat:@"%d", (int)newTime];
	time.x = clock.x - time.width*0.5f;
	
}

-(FFButton*)rightAnswerButton {
    return [answersButtons objectAtIndex:rightAnswerIndex];
}

-(void)showRightAnswer {
	
	task.label = rightAnswer;
	task.x = back.x - task.width * 0.5f;
	for (FFButton* button in answersButtons) {
		[button hide];
	}
}

-(float)width {
	return back.width;
}

-(float)height {
	return clock.height + back.height;
}

-(void)puzzleWasSolved:(Puzzle *)puzzle {
	[self showRightAnswer];
	[[GameUI sharedUI].textPanel setMessage:@"Right!"];
	[finished triggerBy:self];
	
}

-(void)puzzleWasFailed:(Puzzle *)puzzle {
	[self showRightAnswer];
	[[GameUI sharedUI].textPanel setMessage:@"Wrong!"];
	[finished triggerBy:self];
		
}

-(void)showButtons {
}



-(void)dealloc {
	[[FFGame sharedGame] removeFromNotificationCenter:self];
	[finished release];
	[back release];
	[answersButtons release];
	[rightAnswer release];
	[description release];
	[time release];
	[task release];
	[super dealloc];
	
}

@end

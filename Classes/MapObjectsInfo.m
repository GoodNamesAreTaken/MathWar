//
//  BuildingsInfo.m
//  MathWars
//
//  Created by SwinX on 10.08.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#define MAP_OBJECTS_INFO @"MapObjects"

#import <objc/runtime.h>
#import "MapObjectsInfo.h"
#import "RichMessageBoxController.h"
#import "FFGame.h"
#import "TutorialAI.h"

@interface MapObjectsInfo(Private)

-(NSString*)getStringObjectName:(MapObject*)object;
-(BOOL)mustShowInfoAbout:(NSString*)object;

@end


@implementation MapObjectsInfo

static MapObjectsInfo* instance = nil;

+(MapObjectsInfo*)info {
	@synchronized(self) {
		if (instance == nil) {
			instance = [[MapObjectsInfo alloc] init];
		}
	}
	return instance;
}

-(id)init {
	if ((self = [super init])) {
		NSString* path = [[NSBundle mainBundle] pathForResource:MAP_OBJECTS_INFO ofType:@"plist"];
		info = [[NSDictionary alloc] initWithContentsOfFile:path];
	}
	return self;
}

-(void)showInfoAboutObject:(MapObject*)object {
	
	Player* enemy = [[FFGame sharedGame] getModelByName:@"enemy"];
	
	if ([enemy isKindOfClass:[TutorialAI class]] || !enemy) { //Костыль для туториала. Потом сделать человеческую проверку на туториал.
		return;
	}
	
	if (object.guardian.owner == [[FFGame sharedGame] getModelByName:@"player"]) {
		NSString* name = [self getStringObjectName:object];
		if ([self mustShowInfoAbout:name]) {
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:name];
			NSDictionary* infoPart = [info objectForKey:name];
			[RichMessageBoxController showWithHeader:name andPicture:[infoPart objectForKey:@"Picture"] andText:[infoPart objectForKey:@"Text"]];
		}
	}
}

-(BOOL)mustShowInfoAbout:(NSString*)name {
	return ![[NSUserDefaults standardUserDefaults] boolForKey:name];
}

-(NSString*)getStringObjectName:(MapObject*)object {
	return [NSString stringWithUTF8String:class_getName([object class])];
}

/*-(void)reset {	
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Base"];
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Factory"];
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Antenna"];
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Repairer"];
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Swamp"];
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Gorge"];
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"MineField"];
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Barricades"];
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Weaponary"];
}*/

-(void)dealloc {
	[info release];
	[super dealloc];
}

@end

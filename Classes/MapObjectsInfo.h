//
//  BuildingsInfo.h
//  MathWars
//
//  Created by SwinX on 10.08.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "MapObject.h"


@interface MapObjectsInfo : NSObject {
	NSDictionary* info;
}

+(MapObjectsInfo*)info;
-(void)showInfoAboutObject:(MapObject*)object;
//-(void)reset;

@end

/*
 *  PathSearch.h
 *  MathWars
 *
 *  Created by Inf on 06.04.10.
 *  Copyright 2010 Soulteam. All rights reserved.
 *
 */
#import "MapObject.h"


NSArray* searchPath(MapObject* start, MapObject* end) {
	NSMutableArray* open = [NSMutableArray arrayWithObject:start];
	NSMutableDictionary* parents = [NSMutableDictionary dictionary];
	NSMutableArray* closed = [NSMutableArray array];
	
	while (open.count > 0) {
		MapObject* object = [open objectAtIndex:0];
		[open removeObjectAtIndex:0];
		[closed addObject:object];
		
		if (object == end) {
			NSMutableArray* path = [NSMutableArray array];
			while (object != nil) {
				[path insertObject:object atIndex:0];
				object = [parents objectForKey:object];
			}
			return path;
		}
		
		for (MapObject* neighbour in object.neighbours) {
			if (![open containsObject:neighbour] && ![closed containsObject:neighbour]) {
				[open addObject:neighbour];
				[parents setObject:object forKey:neighbour];
			}
		}
	}
	return nil;
}
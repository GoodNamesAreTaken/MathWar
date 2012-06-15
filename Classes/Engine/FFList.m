//
//  FFList.m
//  MathWars
//
//  Created by Inf on 01.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFList.h"

@implementation FFListIterator
@synthesize next, isDead, object;

-(FFListIterator*)nextItem {
	if (self.next.isDead) {
		self.next = [next nextItem];
	}
	return self.next;
}

-(void)dealloc {
	self.next = nil;
	self.object = nil;
	[super dealloc];
}

@end



@implementation FFList
@synthesize first;

-(void)addItem:(id)newItem {
	FFListIterator* newIterator = [[[FFListIterator alloc] init] autorelease];
	newIterator.object = newItem;
	newIterator.isDead = NO;
	newIterator.next = self.first;
	self.first = newIterator;
}

-(FFListIterator*)firstItem {
	if (self.first.isDead) {
		self.first = [self.first nextItem];
	}
	return self.first;
}

-(FFListIterator*)iteratorOf:(id)item {
	for (FFListIterator* iter = [self firstItem]; iter != nil; iter = [iter nextItem]) {
		if (iter.object == item) {
			return iter;
		}
	}
	return nil;
}

-(void)dealloc {
	self.first = nil;
	[super dealloc];
}

@end

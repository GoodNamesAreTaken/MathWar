//
//  FFList.h
//  MathWars
//
//  Created by Inf on 01.07.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

@interface FFListIterator : NSObject
{
	id object;
	BOOL isDead;
	FFListIterator* next;
}

@property BOOL isDead;
@property(retain) id object; 
@property(retain) FFListIterator* next;

-(FFListIterator*) nextItem;
@end



@interface FFList : NSObject {
	FFListIterator* first;
}

@property(retain) FFListIterator* first;

-(void)addItem:(id)newItem;
-(FFListIterator*)firstItem;
-(FFListIterator*)iteratorOf:(id)item;

@end

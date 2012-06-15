//
//  PrimaAlhoritm.h
//  MathWars
//
//  Created by SwinX on 26.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFRib.h"
#import "NetworkProtocol.h"

/**
  Создает остовное дерево из набора переданных вершин с помощью урезанного алгоритма прима. (дерево не минимально)
 */

@interface FFNeighboursCreator : NSObject {

	NSMutableArray* ribs;
	NSMutableArray* initialVerticies;
	NSMutableArray* addedVeriticies;
	NSMutableArray* temporaryRibs;
	
	MWNetWorkMapParams* localParams;
	
}

-(id)initWithMapParams:(MWNetWorkMapParams*)params;
-(void)createSkeleton;


@end

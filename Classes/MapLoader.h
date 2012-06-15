//
//  MapLoader.h
//  MathWars
//
//  Created by Inf on 01.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Player.h"
#import "NetworkProtocol.h"
#import "MapObject.h"
#import "RandomMapPlacer.h"

@class Player;

/**
 Загрузчик карты
 
 Предназначен для загрузки карты из файла либо создания случайной
 */
@interface MapLoader : NSObject {
	NSMutableArray* mapObjects;
	
	MWNetWorkMapParams mapParams;
}

/**
 Созданная карта
 */
@property(readonly) NSArray* map;

@property(readonly) MWNetWorkMapParams* mapTemplate;


/**
 Создает новую случайную карту для заданных игроков
 @param count количестов баз
 @param player первый игрок
 @param enemy второй игрок
 */

+(MapLoader*)sharedLoader;

-(void)loadRandomWithObjectCount:(uint32_t)objectCount player:(Player*)player andEnemy:(Player*)enemy;
-(void)loadFromNetworkParams:(MWNetWorkMapParams*)params withPlayer:(Player*)player andEnemy:(Player*)enemy;
-(void)loadFromFile:(NSString*)fileName withPlayer:(Player*)player andEnemy:(Player*)enemy;
-(void)destroyMap;
-(MapObject*)getMapObjectByID:(uint8_t)objectID;

@end

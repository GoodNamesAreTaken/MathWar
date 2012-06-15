//
//  Building.h
//  MathWars
//
//  Created by Inf on 24.02.10.
//  Copyright 2010 Soulteam. All rights reserved.
//
#import "Player.h"
#import "MapObject.h"

@protocol BuildingDelegate

/**
 Посылается при смене владельца
 
 @param owner новый владелец
 */
-(void)ownerChangedTo:(Player*)owner;

@end


/**
 Постройка
 
 Добавляет к MapObject принадлежность какому-либо игроку. В смены стражника меняет принадлежность.
 */
@interface Building : MapObject {
	Player* owner;
	id delegate;
}

@property(assign) id delegate;
/**
 Владелец постройки
 */
@property(assign) Player* owner;

/**
 Вызывается при смене владельца
 */
-(void)onOwnerChange:(Player*)newOwner;

@end

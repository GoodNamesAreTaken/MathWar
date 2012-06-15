//
//  MapFinisher.h
//  MathWars
//
//  Created by SwinX on 21.05.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Campaign.h"
#import "Player.h"
#import "Campaign.h"
#import "PlayerObserver.h"
#import "FFSound.h"
/**
 Класс, отвечающий за завершение миссий. Вся логика по завершению миссий кампании/одиночных должна быть занесена сюда.
 */

@interface MapFinisher : NSObject<PlayerObserver> {

	Player* humanPlayer;
	Player* looser;
	
	Campaign* campaign;
	FFSound* winSound;
	FFSound* loseSound;
}

@property(readonly) Player* looser;

+(MapFinisher*)sharedFinisher;
-(void)playerSurrendered:(Player *)player;
-(void)playerLostTheGame:(Player*)player;
-(void)finalizeMission;

@end

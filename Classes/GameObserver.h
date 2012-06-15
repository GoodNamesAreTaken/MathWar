//
//  GameObserver.h
//  MathWars
//
//  Created by Inf on 16.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "HumanPlayer.h"
#import "PlayerObserver.h"

/**
 Наблюдатель за состояниями игроков
 
 Реагирует на сообщения о создании паззлов, боя, старте и завершении хода обоих игроков. Добавляет/удаляет из игры требуемые представления и контроллеры
 */
@interface GameObserver : NSObject<PlayerObserver, PuzzleCreationDelegate> {
	BOOL firstTurn;
	Class defaultPuzzleControllerState;
}
@property BOOL firstTurn;
@property(assign) Class defaultPuzzleControllerState;
+(GameObserver*)sharedObserver;

@end

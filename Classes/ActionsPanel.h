//
//  ActionsPanel.h
//  MathWars
//
//  Created by Inf on 03.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFButton.h"
#import "FFBlinkingButton.h"
#import "FFSprite.h"

typedef enum _PanelState {
	APStateActions,
	APStateIdle
}PanelState;

/**
 Интерфейсная панель игры
 
 Содержит кнопки заверщения хода,постройки юнитов и т.п.
 */
@interface ActionsPanel : FFCompositeView {
	FFBlinkingButton* endTurnButton;
	
	FFButton* buildButton;
	FFButton* upgradeButton;
	FFButton* surrenderButton;

	FFSprite* idleIcon;
	PanelState currentState;
	FFSprite* back;
	
}

/**
 Кнопка завершения хода
 */
@property(readonly) FFBlinkingButton* endTurnButton;

/**
 Кнопка апгрейда юнита
 */
@property(readonly) FFButton* upgradeButton;

@property(readonly) FFButton* buildButton;

/**
 Кнопка принудительного проигрыша
 */
@property(readonly) FFButton* surrenderButton;
/**
 Показать кнопки постройки юнитов
 */
-(void)showBuildButtons;

/**
 Показать кнопку апгрейда юнита
 */

-(void)showUpgradeButton;

/**
 Убрать кнопки постройки юнитов
 */
-(void)hideBuildButtons;

/**
 Убрать кнопку апгрейда юнита
 */
-(void)hideUpgradeButton;

/**
 Показать иконку простоя (во время хода противника)
 */
-(void)showIdlePanel;

/**
 Показать кнопку завршения игры
 */
-(void)showActivePanel;


@end

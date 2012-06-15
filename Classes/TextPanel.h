//
//  TextPanel.h
//  MathWars
//
//  Created by Inf on 16.04.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFCompositeView.h"
#import "FFText.h"
#import "FFSprite.h"


@interface TextPanel : FFCompositeView {
	FFText* message;
	FFSprite* back;
}

-(void)setMessage:(NSString*)messageText;
-(void)showMovesCount;
@end

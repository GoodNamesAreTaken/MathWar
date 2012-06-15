//
//  ComparePuzzleView.h
//  MathWars
//
//  Created by Inf on 22.03.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "PuzzleView.h"
#import "ComparePuzzle.h"
#import "FFButton.h"


@interface ComparePuzzleView : PuzzleView {
	FFButton* lesserButton;
	FFButton* equalButton;
	FFButton* greaterButton;
}
@property(readonly) FFButton* lesserButton;
@property(readonly) FFButton* equalButton;
@property(readonly) FFButton* greaterButton;

@end

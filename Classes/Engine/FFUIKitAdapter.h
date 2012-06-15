//
//  FFUIKitAdapter.h
//  MathWars
//
//  Created by Inf on 22.06.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FFController.h"


@interface FFUIKitAdapter : UIViewController<FFController> {
}

+(id)controllerWithNibName:(NSString*)name;


@end

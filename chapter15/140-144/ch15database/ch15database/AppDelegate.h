//
//  AppDelegate.h
//  ch15database
//
//  Created by SHOEISHA on 2014/01/08.
//  Copyright (c) 2014年 SHOEISHA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FMDatabase *database;

@end

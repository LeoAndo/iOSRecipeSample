//
//  MasterViewController.h
//  ch15database
//
//  Created by SHOEISHA on 2014/01/08.
//  Copyright (c) 2014年 SHOEISHA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) FMDatabase *database;

@property (strong, nonatomic) NSMutableArray *stationsDictionary;

@end

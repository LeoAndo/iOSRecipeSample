//
//  DetailViewController.h
//  ch15database
//
//  Created by SHOEISHA on 2014/01/08.
//  Copyright (c) 2014年 SHOEISHA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSMutableDictionary *detailItem;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *distanceField;
@property (weak, nonatomic) IBOutlet UITextField *memoField;

@end

//
//  ViewController.h
//  ch12localnotification
//
//  Created by SHOEISHA on 2013/12/29.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *createLocalNotificationButton;
@property (weak, nonatomic) IBOutlet UILabel *remainLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

- (IBAction)createLocalNotificationButtonDidPush:(id)sender;

- (void)showRemain;

@end

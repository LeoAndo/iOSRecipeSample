//
//  ViewController.h
//  ch12notification
//
//  Created by SHOEISHA on 2013/12/29.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface ViewController : UIViewController <NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIButton *downloadExecuteButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)createLocalNotificationButtonDidPush:(id)sender;

@end

//
//  ViewController.h
//  ch13CustomURLSchemeTargetApp
//
//  Created by HU QIAO on 2013/12/08.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *message;

-(void)showMessage:(NSString*)str;

@end

//
//  ViewController.m
//  ch12remotenotification
//
//  Created by SHOEISHA on 2013/12/29.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.messageTextView.text = appDelegate.message;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

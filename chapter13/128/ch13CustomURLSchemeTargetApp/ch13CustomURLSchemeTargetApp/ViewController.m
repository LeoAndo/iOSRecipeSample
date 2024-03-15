//
//  ViewController.m
//  ch13CustomURLSchemeTargetApp
//
//  Created by HU QIAO on 2013/12/08.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
	[self showMessage:nil];
}


-(void)showMessage:(NSString*)str{
	
	self.message.text = [self.message.text stringByAppendingString:str];
    
}


@end

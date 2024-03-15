//
//  ViewController.m
//  ch13CustomURLSchemeCaller
//
//  Created by HU QIAO on 2013/12/10.
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
}


- (IBAction)callTargetApp:(id)sender {

    //「jp.co.shoeisha.iphonereceipe.ch13CustomURLSchemeTargetApp://」という「URLScheme」を持つアプリに「testinformation」という文字を送る
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"jp.co.shoeisha.iphonereceipe.ch13CustomURLSchemeTargetApp://testinformation"]];

}

@end

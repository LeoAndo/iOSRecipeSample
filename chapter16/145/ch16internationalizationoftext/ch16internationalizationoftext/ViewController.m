//
//  ViewController.m
//  ch16InternationalizationOfText
//
//  Created by katsuya on 2014/01/20.
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

- (IBAction)handleButton:(id)sender {
    NSString *message = NSLocalizedString(@"AlertMessage", @"AlertMessage");
    NSString *title = NSLocalizedString(@"AlertTitle", @"AlertTitle");
    NSString *buttonTitle = NSLocalizedString(@"OK", @"ButtonTitle");
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:message
                               message:title
                              delegate:nil
                     cancelButtonTitle:nil
                     otherButtonTitles:buttonTitle, nil
     ];
    
    [alert show];
}

@end

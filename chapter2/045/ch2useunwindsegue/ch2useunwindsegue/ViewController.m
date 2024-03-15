//
//  ViewController.m
//  ch2UseUnwindSegue
//
//  Created by shoeisha on 2014/03/03.
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

- (IBAction)unwindToScene1:(UIStoryboardSegue *)segue
{
    NSLog(@"unwindToScene1");
}

@end

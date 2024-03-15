//
//  Ch01_UISegmentedControl_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/02/17.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UISegmentedControl_02_ViewController.h"

@interface Ch01_UISegmentedControl_02_ViewController ()

@end

@implementation Ch01_UISegmentedControl_02_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UISegmentedControl *segmentedControl =
            [[UISegmentedControl alloc] initWithItems:@[
             [UIImage imageNamed:@"rewind_to_start_01.png"],
             [UIImage imageNamed:@"play.png"],
             [UIImage imageNamed:@"fast_forward.png"]
            ]];
    CGRect frame = CGRectMake(20,184,226,28);
    segmentedControl.frame = frame;
    segmentedControl.selectedSegmentIndex = 1;
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:segmentedControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

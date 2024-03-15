//
//  Ch01_UISegmentedControl_04_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/02/17.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UISegmentedControl_04_ViewController.h"

@interface Ch01_UISegmentedControl_04_ViewController ()

@end

@implementation Ch01_UISegmentedControl_04_ViewController

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
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(20,110,226,28)];
    [segmentedControl insertSegmentWithTitle:@"First" atIndex:0 animated:false];
    [segmentedControl insertSegmentWithTitle:@"Second" atIndex:1 animated:false];
    [segmentedControl insertSegmentWithTitle:@"Third" atIndex:2 animated:false];
    
    [self.view addSubview:segmentedControl];
    
    UIFont *font = [UIFont italicSystemFontOfSize:16];
    
    NSDictionary *normaltextAttr =
    @{NSFontAttributeName :font};
    
    [segmentedControl setTitleTextAttributes:normaltextAttr forState:UIControlStateNormal];
    
    segmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(20,205,226,28)];
    [segmentedControl insertSegmentWithTitle:@"First" atIndex:0 animated:false];
    [segmentedControl insertSegmentWithTitle:@"Second" atIndex:1 animated:false];
    [segmentedControl insertSegmentWithTitle:@"Third" atIndex:2 animated:false];
    
    [self.view addSubview:segmentedControl];
    
    font = [UIFont italicSystemFontOfSize:20];
    
    normaltextAttr =
    @{NSFontAttributeName :font};
    
    [segmentedControl setTitleTextAttributes:normaltextAttr forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

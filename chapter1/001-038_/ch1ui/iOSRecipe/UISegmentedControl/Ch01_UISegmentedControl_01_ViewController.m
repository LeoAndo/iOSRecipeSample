//
//  Ch01_UISegmentedControl_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/02/17.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UISegmentedControl_01_ViewController.h"

@interface Ch01_UISegmentedControl_01_ViewController ()

@end

@implementation Ch01_UISegmentedControl_01_ViewController

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
    self.uiSegmentControl.selectedSegmentIndex = 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

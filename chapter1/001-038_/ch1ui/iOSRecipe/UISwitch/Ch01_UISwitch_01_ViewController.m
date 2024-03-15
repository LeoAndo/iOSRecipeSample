//
//  Ch01_UISwitch_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/02/17.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UISwitch_01_ViewController.h"

@interface Ch01_UISwitch_01_ViewController ()

@end

@implementation Ch01_UISwitch_01_ViewController

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
   
    self.uiSwitch.onTintColor = [UIColor redColor];
    self.uiSwitch.tintColor = [UIColor blueColor];
    self.uiSwitch.thumbTintColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

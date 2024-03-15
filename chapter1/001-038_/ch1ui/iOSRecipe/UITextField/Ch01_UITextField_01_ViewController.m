//
//  Ch01_UITextField_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/05.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UITextField_01_ViewController.h"

@interface Ch01_UITextField_01_ViewController ()

@end

@implementation Ch01_UITextField_01_ViewController

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
    // Do any additional setup after loading the view from its nib.
    self.textfield1.secureTextEntry=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

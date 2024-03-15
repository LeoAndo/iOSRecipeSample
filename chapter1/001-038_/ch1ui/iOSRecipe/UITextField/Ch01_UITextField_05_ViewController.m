//
//  Ch01_UITextField_05_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/26.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UITextField_05_ViewController.h"

@interface Ch01_UITextField_05_ViewController ()

@end

@implementation Ch01_UITextField_05_ViewController

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
    self.textfield1.clearButtonMode = UITextFieldViewModeNever;
    self.textfield2.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textfield3.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.textfield4.clearButtonMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

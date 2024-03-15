//
//  Ch01_UIDatePicker_03_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/26.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIDatePicker_03_ViewController.h"

@interface Ch01_UIDatePicker_03_ViewController ()

@end

@implementation Ch01_UIDatePicker_03_ViewController

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
    //７日前を指定する
    self.datepicker1.minimumDate=[NSDate dateWithTimeIntervalSinceNow:86400*(-7)];
    //７日後を指定する
    self.datepicker1.maximumDate=[NSDate dateWithTimeIntervalSinceNow:86400*7];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

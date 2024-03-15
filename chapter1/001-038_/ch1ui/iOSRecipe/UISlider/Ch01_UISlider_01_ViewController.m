//
//  Ch01_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2013/12/12.
//  Copyright (c) 2013年 shaoeisya. All rights reserved.
//

#import "Ch01_UISlider_01_ViewController.h"

@interface Ch01_UISlider_01_ViewController ()

@end

@implementation Ch01_UISlider_01_ViewController

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
    
}

-(void)viewDidAppear:(BOOL)bl{
    [super viewDidAppear:bl];
    // 時計回りに90度回転して表示する
    self.uislider.transform = CGAffineTransformMakeRotation(90.0f * M_PI/180.f);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

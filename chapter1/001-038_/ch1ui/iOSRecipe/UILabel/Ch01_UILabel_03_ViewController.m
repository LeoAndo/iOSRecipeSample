//
//  Ch01_003_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2013/10/23.
//  Copyright (c) 2013年 shaoeisya. All rights reserved.
//

#import "Ch01_UILabel_03_ViewController.h"
//QuartzCoreフレームワークをプロジェクトに追加した後、
//UILabelを利用しているクラスファイルにimport文でQuartzCoreヘッダファイルを読み込みます
#import <QuartzCore/QuartzCore.h>



@interface Ch01_UILabel_03_ViewController ()

@end

@implementation Ch01_UILabel_03_ViewController

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
    
    //枠線の色を指定する
    self.label1.layer.borderColor =[[UIColor blueColor] CGColor];
    //枠線の幅を指定する 
    self.label1.layer.borderWidth=1.0f;
    //角丸半径を指定する
    self.label1.layer.cornerRadius=10.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

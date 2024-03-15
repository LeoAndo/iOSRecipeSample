//
//  Ch01_005_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2013/10/25.
//  Copyright (c) 2013年 shaoeisya. All rights reserved.
//

#import "Ch01_UIProgressView_02_ViewController.h"

@interface Ch01_UIProgressView_02_ViewController ()

@end

@implementation Ch01_UIProgressView_02_ViewController

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
    
    //スタイルをDefaultにセットする
    self.progressview1.progressViewStyle = UIProgressViewStyleDefault;
    //左側の色を赤にセットする
    self.progressview1.progressTintColor = [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    //右側の色を緑にセットする
    self.progressview1.trackTintColor = [UIColor colorWithRed:0.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    
}

-(void)viewDidAppear:(BOOL)bl{
    [super viewDidAppear:bl];
    // 横方向に1倍。縦方向を12.0fに変更するときの倍率は自動計算（iOS7でheight=2のため、倍率は6になっている）
    self.progressview2.transform = CGAffineTransformMakeScale(1.0f, 12.0f/ self.progressview1.bounds.size.height);
    
    // 時計回りに90度回転して表示する
    self.progressview3.transform = CGAffineTransformMakeRotation(90.0f * M_PI/180.f);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  Ch01_UIImageView_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/27.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIImageView_02_ViewController.h"

@interface Ch01_UIImageView_02_ViewController ()
{
    UIImageView *imageView;
}
@end

@implementation Ch01_UIImageView_02_ViewController

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
    // 画像を表示する
    UIImage *image = [UIImage imageNamed:@"sample.jpg"];
    imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(20, 120, 260, 400);
    [self.view addSubview:imageView];
}
- (IBAction)scaleImageView:(id)sender {
    //画像の横幅と縦幅を0.5倍に縮小する
    CGAffineTransform t2 = CGAffineTransformMakeScale(0.5,0.5);
    imageView.transform = t2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

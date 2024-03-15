//
//  Ch01_UIImageView_04_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/27.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIImageView_04_ViewController.h"

@interface Ch01_UIImageView_04_ViewController ()
{
    UIImageView *imageView;
}
@end

@implementation Ch01_UIImageView_04_ViewController

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
- (IBAction)rotateImageView:(id)sender {
    // 時計回りに90度回転
    float angle = 90.0 * M_PI / 180;
    CGAffineTransform t2 = CGAffineTransformMakeRotation(angle);
    imageView.transform = t2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

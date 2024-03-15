//
//  Ch01_UIImageView_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/26.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIImageView_01_ViewController.h"

@interface Ch01_UIImageView_01_ViewController ()

@end

@implementation Ch01_UIImageView_01_ViewController

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
    UIImage *image = [UIImage imageNamed:@"red.png"];
    self.imageView1.image=image;
    
    //NSURLを作る
    NSURL *imageURL = [NSURL URLWithString:@"http://books.shoeisha.co.jp/images/banner/174.gif"];
    //NSURLオブジェクトからデータを作る
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    //読み込んだ画像データでUIImageを作る
    UIImage *uiImage = [UIImage imageWithData:imageData];
    //UIImageをUIImageViewのimageプロパティに設定する
    self.imageView2.image = uiImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

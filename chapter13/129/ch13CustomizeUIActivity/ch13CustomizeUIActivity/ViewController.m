//
//  ViewController.m
//  ch13CustomizeUIActivity
//
//  Created by HU QIAO on 2013/12/07.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "LINEActivity.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//テキストを投稿する
- (IBAction)shareTextToLine:(id)sender {
    
    //投稿内容
    NSString *plainString = @"LINEで送る　投稿内容 http://www.shoeisha.co.jp";
    
    //パーセントエンコーディング（utf-8）したテキスト情報の値を指定します。
    NSString *postString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (CFStringRef)plainString,
                                                                                        NULL,
                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                        kCFStringEncodingUTF8 );
    [self shareItem:postString];
    
}

//画像を投稿する
- (IBAction)shareImageToLine:(id)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shoeisha_logo" ofType:@"jpg"];
    [self shareItem:[[UIImage alloc]initWithContentsOfFile:imagePath]];

}

- (void)shareItem:(id)item
{
    
    //activityItemsには共有するオブジェクトを配列で渡します。
    NSArray *activityItems = @[item];
    
    //カスタマイズLINEActivityを呼び出す
    NSArray *applicationActivities = @[[[LINEActivity alloc] init]];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    [self presentViewController:activityViewController animated:YES completion:NULL];
    
}


@end

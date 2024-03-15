//
//  ViewController.m
//  ch13LineButton
//
//  Created by HU QIAO on 2013/12/03.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

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

- (IBAction)postImgToLine:(id)sender {

    //必ずpasteboardをgeneralにしてください。
    //ios7からgeneralでないとLINEへ画像を投稿出来なくなりました。
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shoeisha_logo" ofType:@"jpg"];
  	UIImage *image = [[UIImage alloc]initWithContentsOfFile:imagePath];
    [pasteboard setData:UIImageJPEGRepresentation(image, 0.5) forPasteboardType:@"public.jpeg"];
    
    
    //画像を送るときに指定
    NSString *contentType = @"image";
    
    NSString *urlString = [NSString stringWithFormat:@"line://msg/%@/%@", contentType, pasteboard.name];
    NSURL *url = [NSURL URLWithString:urlString];

    // LINE に直接遷移
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        //LINEがインストールされていない場合
        NSLog(@"the LINE app is not installed.");
    }

}

- (IBAction)postTextToLine:(id)sender {
    
    //投稿内容
    NSString *plainString = @"LINEで送る　投稿内容 http://www.shoeisha.co.jp";

    //パーセントエンコーディング（utf-8）したテキスト情報の値を指定
    NSString *contentKey = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (CFStringRef)plainString,
                                                                                        NULL,
                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                        kCFStringEncodingUTF8 );
    //テキスト情報を送るときに指定
    NSString *contentType = @"text";
    
    NSString *urlString = [NSString stringWithFormat:@"line://msg/%@/%@", contentType, contentKey];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // LINE に直接遷移
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        //LINEがインストールされていない場合
        NSLog(@"the LINE app is not installed.");
    }
    
}

@end

//
//  ViewController.m
//  ch14ResourceFile
//
//  Created by HU QIAO on 2014/01/19.
//  Copyright (c) 2014年 shoeisya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UITextView *myText;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // リソースファイルパスを取得 (pathForResourceを使用)
    NSString *imgfilePath = [[NSBundle mainBundle] pathForResource:@"shoeisha_logo" ofType:@"gif"];
    NSLog(@"shoeisha_logo.gifのパス%@", imgfilePath);
    
    UIImage *image = [UIImage imageWithContentsOfFile:imgfilePath];
    if (image) {
        //　UIImageView にセット
        _myImage.image = image;
    }
    
    // リソースファイルパスを取得 (リソースパスをアペンド)
    // バンドルのパスを取得する
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    // バンドルのパスをアペンド
    NSString *textFilePath = [bundlePath stringByAppendingPathComponent:@"hello.txt"];
    NSLog(@"Hello.txtのパス%@", textFilePath);
    
    NSString *textString = [NSString stringWithContentsOfFile: textFilePath encoding: NSUTF8StringEncoding error:NULL];
    NSLog(@"Hello.txt:%@", textString);

    _myText.text = textString;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

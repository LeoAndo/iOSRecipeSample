//
//  ViewController.m
//  ch3longpress
//
//  Created by katsuya on 2013/11/23.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // UILongPressGestureRecognizerのインスタンスを生成する
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                                initWithTarget:self
                                                                action:@selector(handleLongPressGesture:)];
    
    // 許容する指が動く範囲を指定する
    longPressGestureRecognizer.allowableMovement = 20;  // 20px
    
    // イベントが発生するまで押し続けるする時間を設定する(初期値 0.5秒)
    longPressGestureRecognizer.minimumPressDuration = 0.3f; // 0.3秒
    
    // パンを検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:longPressGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"ロングプレスが検出されました";
}

@end

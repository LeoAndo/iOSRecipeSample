//
//  ViewController.m
//  ch3swipe
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
    
    // UISwipeGestureRecognizerのインスタンスを生成する
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(handleRightSwipeGesture:)];
    
    // 右方向へのスワイプを検出するに設定する
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    // スワイプを検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];

    
    // UISwipeGestureRecognizerのインスタンスを生成する
    UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                             initWithTarget:self
                                                             action:@selector(handleLeftSwipeGesture:)];
    
    // 左方向へのスワイプを検出するに設定する
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    // スワイプを検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:leftSwipeGestureRecognizer];

    
    // UISwipeGestureRecognizerのインスタンスを生成する
    UISwipeGestureRecognizer *upSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                             initWithTarget:self
                                                             action:@selector(handleUpSwipeGesture:)];
    
    // 上方向へのスワイプを検出するに設定する
    upSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    // スワイプを検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:upSwipeGestureRecognizer];
    
    
    // UISwipeGestureRecognizerのインスタンスを生成する
    UISwipeGestureRecognizer *downSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            action:@selector(handleDownSwipeGesture:)];
    
    // 下方向へのスワイプを検出するに設定する
    downSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    
    // スワイプを検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:downSwipeGestureRecognizer];
    
    // UISwipeGestureRecognizerのインスタンスを生成する
    UISwipeGestureRecognizer *twoFingerSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            action:@selector(handleTwoFingerSwipeGesture:)];
    
    // 右方向へのスワイプを検出するに設定する
    twoFingerSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    // 検出する指の数を2に設定する(初期値は1)
    twoFingerSwipeGestureRecognizer.numberOfTouchesRequired = 2;
    
    // スワイプを検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:twoFingerSwipeGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleRightSwipeGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"右方向へのスワイプを検出しました";
}

- (void)handleLeftSwipeGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"左方向へのスワイプを検出しました";
}

- (void)handleUpSwipeGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"上方向へのスワイプを検出しました";
}

- (void)handleDownSwipeGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"下方向へのスワイプを検出しました";
}

- (void)handleTwoFingerSwipeGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"2本指でのスワイプを検出しました";
}

@end

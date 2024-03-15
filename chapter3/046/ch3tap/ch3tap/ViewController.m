//
//  ViewController.m
//  ch3tap
//
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
    
    // UITapGestureRecognizerのインスタンスを生成する
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(handleSingleTapGesture:)];
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(handleDoubleTapGesture:)];
    UITapGestureRecognizer *twoFingersTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                              initWithTarget:self
                                                              action:@selector(handleTwoFingersTapGesture:)];

    // シングルタップを検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:singleTapGestureRecognizer];

    // 検出するタップ数を2に設定する(初期値は1)
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;

    // ダブルタップを検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];

    // 検出する指の数（同時にタッチされた数）を2に設定する(初期値は1)
    twoFingersTapGestureRecognizer.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:twoFingersTapGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleSingleTapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"シングルタップを検出しました";
}

- (void)handleDoubleTapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"ダブルタップを検出しました";
}

- (void)handleTwoFingersTapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"2本指によるタップを検出しました";
}

@end

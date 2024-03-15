//
//  ViewController.m
//  ch3pan
//
//  Created by katsuya on 2013/11/21.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lacationLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UITapGestureRecognizerのインスタンスを生成する
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(handlePanGesture:)];
    
    // パンを検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    // UITapGestureRecognizerのインスタンスを生成する
    UIPanGestureRecognizer *twoFingerPanGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handleTwoFingerPanGesture:)];
    
    // 検出する最大の指の数を2に設定する(初期値は1)
    twoFingerPanGestureRecognizer.maximumNumberOfTouches = 2;
    // 検出する最小の指の数を2に設定する(初期値は1)
    twoFingerPanGestureRecognizer.minimumNumberOfTouches = 2;
    
    // パンを検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:twoFingerPanGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    CGPoint location = [gestureRecognizer translationInView:self.view];
    self.label.text = @"1本指でのパンを検出しました";
    self.lacationLabel.text = [NSString stringWithFormat:@"x:%f  y:%f", location.x, location.y];
}

- (void)handleTwoFingerPanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    CGPoint location = [gestureRecognizer translationInView:self.view];
    self.label.text = @"2本指でのパンを検出しました";
    self.lacationLabel.text = [NSString stringWithFormat:@"x:%f  y:%f", location.x, location.y];
}


@end

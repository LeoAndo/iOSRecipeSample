//
//  ViewController.m
//  ch3simultaneously
//
//  Created by katsuya on 2013/11/26.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rotationLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinchLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UIPinchGestureRecognizerのインスタンスを生成する
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePinchGesture:)];
    
    // delegateを設定する
    pinchGestureRecognizer.delegate = self;
    
    // ピンチを検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:pinchGestureRecognizer];

    // UIRotationGestureRecognizerのインスタンスを生成する
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc]
                                                              initWithTarget:self
                                                              action:@selector(handleRotationGesture:)];

    // delegateを設定する
    rotationGestureRecognizer.delegate = self;

    // 回転を検出するようにGestureRecognizerをViewに設定する
    [self.view addGestureRecognizer:rotationGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    self.pinchLabel.text = @"ピンチを検出しました";
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);

    self.rotationLabel.text = @"回転を検出しました";
}

@end

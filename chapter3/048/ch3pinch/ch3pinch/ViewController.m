//
//  ViewController.m
//  ch3pinch
//
//  Created by katsuya on 2013/11/23.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UIPinchGestureRecognizerのインスタンスを生成する
  UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(handlePinchGesture:)];
  
  // ピンチを検出するようにGestureRecognizerをViewに設定する
  [self.view addGestureRecognizer:pinchGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
  NSLog(@"%s", __PRETTY_FUNCTION__);
  CGFloat scale = gestureRecognizer.scale;
  CGFloat velocity= gestureRecognizer.velocity;
  
  if (velocity > 0) {
    self.label.text = @"ピンチアウトが検出されました";
  } else {
    self.label.text = @"ピンチインが検出されました";
  }
  
  self.valueLabel.text = [NSString stringWithFormat:@"Scale:%f  Velocity:%f", scale, velocity];
}

@end

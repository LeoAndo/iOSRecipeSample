//
//  ViewController.m
//  ch3rotation
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
  
  // UIRotationGestureRecognizerのインスタンスを生成する
  UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(handleRotationGesture:)];
  
  // 回転を検出するようにGestureRecognizerをViewに設定する
  [self.view addGestureRecognizer:rotationGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)gestureRecognizer
{
  NSLog(@"%s", __PRETTY_FUNCTION__);
  CGFloat rotation = gestureRecognizer.rotation;
  CGFloat velocity= gestureRecognizer.velocity;

  if (rotation > 0) {
    self.label.text = @"右回転を検出しました";
  } else {
    self.label.text = @"左回転を検出しました";
  }

  self.valueLabel.text = [NSString stringWithFormat:@"Rotation:%f  Velocity:%f", rotation, velocity];
}

@end

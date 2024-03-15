//
//  ViewController.m
//  ch10Accelerometer
//
//  Created by shoeisha on 2013/11/04.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "ViewController.h"

@interface ViewController ()
{
    IBOutlet UILabel* x;
    IBOutlet UILabel* y;
    IBOutlet UILabel* z;
    
    CMMotionManager* manager;
}
@end

@implementation ViewController

- (IBAction)stop:(UIButton*)sender
{
    if (manager.deviceMotionActive) {
        [manager stopDeviceMotionUpdates];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // MotionManagerを生成
    manager = [[CMMotionManager alloc] init];
    
    // 取得間隔を設定(上限はハードウェア依存 < 100Hz)
    manager.deviceMotionUpdateInterval = 0.1; // 10Hz
    
    // センサー取得の可否を確認
    if (manager.deviceMotionAvailable) {
#if 0
        // PULL型 : 以後、各パラメーターが自動更新される
        [manager startDeviceMotionUpdates];
#else
        // PUSH型 : 以後、指定したユーザ処理が定期実行される
        [manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                     withHandler:^(CMDeviceMotion* motion, NSError* error) {
                                         // 加速度データの取得[G : 1.0 = 9.8m/s]
                                         //CMAcceleration g = motion.gravity;
                                         CMAcceleration g = motion.userAcceleration;
                                         
                                         x.text = [NSString stringWithFormat:@"%.2f", g.x];
                                         y.text = [NSString stringWithFormat:@"%.2f", g.y];
                                         z.text = [NSString stringWithFormat:@"%.2f", g.z];
                                     }];
#endif
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self stop:nil];
}

@end

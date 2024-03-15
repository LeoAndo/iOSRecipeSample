//
//  ViewController.m
//  ch10Magnetomater
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
    
    IBOutlet UILabel* h;
    
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
        [manager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXTrueNorthZVertical
                                                     toQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMDeviceMotion* motion, NSError* error) {
                                                     // 磁力データの処理[μT]
                                                     CMMagneticField mf = motion.magneticField.field;
                                                     x.text = [NSString stringWithFormat:@"%.2f", mf.x];
                                                     y.text = [NSString stringWithFormat:@"%.2f", mf.y];
                                                     z.text = [NSString stringWithFormat:@"%.2f", mf.z];
                                                     
                                                     // Z軸を鉛直方向に「真北」を0、東を90、南を180、西を270度と計算
                                                     double heading = fmod(270 + atan2(mf.y, mf.x) * 180 / M_PI, 360);
                                                     h.text = [NSString stringWithFormat:@"%.2f", heading];
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

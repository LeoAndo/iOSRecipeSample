//
//  ViewController.m
//  ch10Proximity
//
//  Created by shoeisha on 2013/11/04.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    IBOutlet UILabel* state;
    IBOutlet UISwitch* autostop;
}
@end

@implementation ViewController

- (IBAction)stop:(UIButton*)sender
{
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceProximityStateDidChangeNotification
                                                  object:nil];
}

- (IBAction)proximityMinitoring:(UISwitch*)sender
{
    if (sender.isOn == NO) [UIDevice currentDevice].proximityMonitoringEnabled = YES;
}

- (void)proximityStateDidChange:(NSNotification*)notification
{
    // センサーの状態が変化
    if ([UIDevice currentDevice].proximityState == NO) {
        state.text = @"NO";
    } else {
        state.text = @"YES";
        
        if (autostop.isOn) {
            // 近接センサオフ
            [UIDevice currentDevice].proximityMonitoringEnabled = NO;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // 近接センサー状態監視
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    
    // 近接センサー状態通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(proximityStateDidChange:)
                                                 name:UIDeviceProximityStateDidChangeNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

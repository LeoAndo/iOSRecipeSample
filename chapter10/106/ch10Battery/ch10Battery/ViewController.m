//
//  ViewController.m
//  ch10Battery
//
//  Created by shoeisha on 2013/11/04.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    IBOutlet UILabel* level;
}
@end

@implementation ViewController

- (IBAction)stop:(UIButton*)sender
{
    [UIDevice currentDevice].batteryMonitoringEnabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceBatteryLevelDidChangeNotification
                                                  object:nil];
}

- (void)batteryLevelDidChange:(NSNotification *)notification
{
    level.text = [NSString stringWithFormat:@"%d%%", (int)([UIDevice currentDevice].batteryLevel * 100)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // バッテリー状態監視
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    
    // バッテリー状態通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(batteryLevelDidChange:)
                                                 name:UIDeviceBatteryLevelDidChangeNotification
                                               object:nil];
    
    // 現在の状態
    [self batteryLevelDidChange:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

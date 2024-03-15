//
//  ViewController.m
//  ch10GpsLocation
//
//  Created by shoeisha on 2013/11/04.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate>
{
    IBOutlet UILabel* longitude;
    IBOutlet UILabel* latitude;
    IBOutlet UILabel* altitude;

    IBOutlet UILabel* speed;
    
    CLLocationManager* manager;
}
@end

@implementation ViewController

- (IBAction)stop:(UIButton*)sender
{
    if (manager != nil) {
        [manager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    latitude.text  = [NSString stringWithFormat:@"%.6f", newLocation.coordinate.latitude];
    longitude.text = [NSString stringWithFormat:@"%.6f", newLocation.coordinate.longitude];
    altitude.text  = [NSString stringWithFormat:@"%.6f", newLocation.altitude];
    
    speed.text     = [NSString stringWithFormat:@"%.2f m/s", newLocation.speed];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    // 位置情報取得失敗時の処理
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // 位置情報サービスの利用確認
    if ([CLLocationManager locationServicesEnabled]) {
        manager = [[CLLocationManager alloc] init];
 
        // 通知イベントをこのクラスで受ける
        manager.delegate = self;
        
        // 最高精度を設定
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        // 移動距離が変化した際にイベントを起こす値(メートル)を指定、kCLDistanceFilterNoneで逐次。
        manager.distanceFilter = kCLDistanceFilterNone;
        
        // 位置情報取得開始
        [manager startUpdatingLocation];
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

//
//  ViewController.m
//  ch11GpsLogger
//
//  Created by j9 on 2013/12/31.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate>
{
    IBOutlet UITextView* textView;
    
    CLLocationManager* manager;
}
@end

@implementation ViewController

- (NSString*)now
{
    // 書式指定で現在の日時を返す
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.locale     = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    
    return [formatter stringFromDate:[NSDate date]];
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    textView.text = [[NSString stringWithFormat:@"[%@] %.6f %.6f %.6f\n",
                      [self now],
                      newLocation.coordinate.latitude,
                      newLocation.coordinate.longitude,
                      newLocation.altitude] stringByAppendingString:textView.text];
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
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // 位置情報サービスの利用確認
    if ([CLLocationManager locationServicesEnabled]) {
        manager = [[CLLocationManager alloc] init];
        
        // 通知イベントをこのクラスで受ける
        manager.delegate = self;
        
        // 最高精度を設定
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        // 移動距離が変化した際にイベントを起こす値(メートル)を指定、kCLDistanceFilterNoneで逐次。
        manager.distanceFilter = kCLDistanceFilterNone;
        
        // 位置情報取得自動停止無効
        manager.pausesLocationUpdatesAutomatically = NO;
        
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
    if (manager != nil) {
        [manager stopUpdatingLocation];
    }
}

@end

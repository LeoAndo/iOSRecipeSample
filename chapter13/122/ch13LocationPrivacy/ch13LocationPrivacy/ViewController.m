//
//  ViewController.m
//  ch13LocationPrivacy
//
//  Created by HU QIAO on 2013/11/24.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ViewController.h"

@interface ViewController ()<CLLocationManagerDelegate>
{
@private
    NSDate *_startUpdatingLocationAt;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *getLocationButton;

// LocationManagerインスタンス
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // 位置情報サービスを停止する
    [self stopLocationService];
}

//プライバシー→位置情報サービスの状態ボタンを押下した時の処理
- (IBAction)checkLocationServiceAuthorizationStatus:(id)sender {
    
    if(![CLLocationManager locationServicesEnabled])
    {
        
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:NSLocalizedString(@"位置情報サービスをOFFになっている。", nil)
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
    } else {
        
        //アプリ起動後、位置情報サービスへのアクセスを許可するかまだ選択されていない状態
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                            message:@"ユーザーにまだ位置情報サービスへのアクセス許可を求めていない"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        //設定 > 一般 > 機能制限により位置情報サービスの利用が制限されている状態
        else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                            message:@"iPhoneの設定の「機能制限」で位置情報サービスの利用を制限している"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        //ユーザーがこのアプリでの位置情報サービスへのアクセスを許可していない状態
        else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                            message:@"ユーザーがこのアプリでの位置情報サービスへのアクセスを許可していない"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        //ユーザーがこのアプリでの位置情報サービスへのアクセスを許可している状態
        else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                            message:@"ユーザーがこのアプリでの位置情報サービスへのアクセスを許可している"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}



//位置情報取得ボタンを押下した時の処理
- (IBAction)getLocation:(id)sender {
    
    //位置情報サービスの状態を確認する
    if ([self checkLocationService]){

        //位置情報サービスへの認証状態を確認する
        if([self checkCLAuthorizationStatus]){
    
            // 測位開始
            [_locationManager startUpdatingLocation];
            
            _getLocationButton.enabled = NO;
            _startUpdatingLocationAt = [NSDate date];
        };
    }
}

// 位置情報サービスを停止する
- (void)stopLocationService
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;

}

//位置情報サービスの状態を確認する
-(BOOL) checkLocationService
{
    if(![CLLocationManager locationServicesEnabled])
    {
        
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:NSLocalizedString(@"位置情報サービスをONにしてください。", nil)
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
        return  NO;
    }
    return YES;
}


//位置情報サービスへの認証状態を確認する
-(BOOL)checkCLAuthorizationStatus
{
    // このアプリの位置情報サービスへの認証状態を取得する
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    switch (status) {
        case kCLAuthorizationStatusAuthorized:
        // 位置情報サービスへのアクセスが許可されている
        case kCLAuthorizationStatusNotDetermined:
        // アプリ起動後、位置情報サービスへのアクセスを許可するかまだ選択されていない状態
        {
            // 位置情報サービスへのアクセスを許可するか確認するダイアログを表示する
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            [self.locationManager startUpdatingLocation];
            _getLocationButton.enabled = NO;
            _startUpdatingLocationAt = [NSDate date];
        }
            return YES;
        case kCLAuthorizationStatusRestricted:
        // 設定 > 一般 > 機能制限で位置情報サービスの利用が制限されている
        {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"機能制限で位置情報サービスの利用が制限されている", nil)
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
            _getLocationButton.enabled = YES;
        }
            return NO;
        case kCLAuthorizationStatusDenied:
        // ユーザーがこのアプリでの位置情報サービスへのアクセスを許可していない
        {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"ユーザーがこのアプリでの位置情報サービスへのアクセスを許可していない", nil)
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
            _getLocationButton.enabled = YES;
        }
            return NO;
        default:
        {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"位置情報サービスの認証情報が取得できない", nil)
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
            _getLocationButton.enabled = YES;
        }
            return NO;
    }
}


// 位置情報が更新された時、このデリゲートメソッドが呼ばれる
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *recentLocation = locations.lastObject;
    if (recentLocation.timestamp.timeIntervalSince1970 < _startUpdatingLocationAt.timeIntervalSince1970) {
        return;
    }
    
    [_locationManager stopUpdatingLocation];
    
    _getLocationButton.enabled = YES;
    
    //MapViewを更新
    [_mapView setCenterCoordinate:recentLocation.coordinate animated:YES];
    
    MKPointAnnotation *mapAnnotation = [[MKPointAnnotation alloc] init];
    mapAnnotation.coordinate = recentLocation.coordinate;
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotation:mapAnnotation];
    
}

// 測位失敗した場合にこのデリゲートメソッドが呼ばれる
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self stopLocationService];
    
    _getLocationButton.enabled = YES;

    [[[UIAlertView alloc] initWithTitle:nil
                                message:NSLocalizedString(@"測位に失敗しました。", nil)
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"OK", nil] show];
}


// 位置情報サービスの設定が変更された場合、このデリゲートメソッドが呼ばれる
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusRestricted:
        // 機能制限で位置情報サービスの利用を「オフ」から変更できないようにした場合
        {
            // 位置情報サービスを停止する
            [self stopLocationService];
            _getLocationButton.enabled = YES;
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"機能制限で位置情報サービスの利用が制限されています", nil)
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
        }
            break;
        case kCLAuthorizationStatusDenied:
        // ユーザーがこのアプリの位置情報サービスへのアクセス許可を「オフ」にした場合
        {
            // 位置情報サービスを停止する
            [self stopLocationService];
            _getLocationButton.enabled = YES;
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"ユーザーがこのアプリでの位置情報サービスへのアクセスを許可していません", nil)
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
        }
            break;
        default:
            break;
    }
}

@end

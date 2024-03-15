//
//  ViewController.m
//  ch9UseMapKitAnnotation
//
//  Created by shoeisha on 2014/01/26.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 表示座標
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(35.689487, 139.691706);
    
    // ピン用アノテーションを生成
    MKPointAnnotation* pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = loc;   // ピンの座標

    // アノテーション文言をセット
    pin.title = @"この場所は";
    pin.subtitle = @"東京都庁です";

    // ピンを設定
    [self.mapView addAnnotation:pin];
    
    // 表示位置とサイズを設定
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake(loc, span);
    [self.mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

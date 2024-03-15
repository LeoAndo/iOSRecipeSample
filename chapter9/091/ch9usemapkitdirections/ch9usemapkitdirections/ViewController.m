//
//  ViewController.m
//  ch9UseMapKitDirections
//
//  Created by shoeisha on 2014/01/26.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 表示位置を指定
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(35.689487, 139.691706);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.02);
    self.mapView.region = MKCoordinateRegionMake(loc, span);
    
    // 東京都庁の座標
    CLLocationCoordinate2D loc1 = CLLocationCoordinate2DMake(35.689487, 139.691706);
    
    // 新宿警察署の座標
    CLLocationCoordinate2D loc2 = CLLocationCoordinate2DMake(35.693468, 139.694456);
    
    // ピンを表示
    MKPointAnnotation *pin1 = [[MKPointAnnotation alloc] init];
    pin1.coordinate = loc1;
    [self.mapView addAnnotation:pin1];
    MKPointAnnotation *pin2 = [[MKPointAnnotation alloc] init];
    pin2.coordinate = loc2;
    [self.mapView addAnnotation:pin2];
    
    
    // 座標 から MKPlacemark を生成
    MKPlacemark *mark1 = [[MKPlacemark alloc] initWithCoordinate:loc1 addressDictionary:nil];
    MKPlacemark *mark2   = [[MKPlacemark alloc] initWithCoordinate:loc2 addressDictionary:nil];
    
    // MKPlacemark から MKMapItem を生成
    MKMapItem *item1 = [[MKMapItem alloc] initWithPlacemark:mark1];
    MKMapItem *item2   = [[MKMapItem alloc] initWithPlacemark:mark2];
    
    // MKMapItem をセットして MKDirectionsRequest を生成
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = item1;
    request.destination = item2;
    request.transportType = MKDirectionsTransportTypeWalking; // 徒歩を指定
    request.requestsAlternateRoutes = NO;
    
    // MKDirectionsRequest から MKDirections を生成
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    // 経路検索を実行
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             return;
         }
         
         if ([response.routes count] > 0) {
             MKRoute *route = [response.routes objectAtIndex:0];
             // ルートを描画
             [self.mapView addOverlay:route.polyline];
         }
     }];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        // 経路を表わす線の太さ
        routeRenderer.lineWidth = 3.0;
        // 経路を表わす線の色指定
        routeRenderer.strokeColor = [UIColor blueColor];
        return routeRenderer;
    } else {
        return nil;
    }
}

@end

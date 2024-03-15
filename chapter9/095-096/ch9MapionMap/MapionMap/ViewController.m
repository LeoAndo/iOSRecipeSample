//
//  ViewController.m
//  MapionMap
//
//  Created by Mika Yamamoto on 2014/02/20.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import "ViewController.h"
#import <MapionMaps/MapionMaps.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MMMapView *mapView = [[MMMapView alloc] initWithFrame:[[self view] bounds] key:@"410d196140ce3d8884bf9c4ff926c20b"];
    [self.view addSubview:mapView];
    
    [mapView setZoom:12.3 animated:NO];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(35.3, 139.3);
    [mapView setCenterCoordinate:coordinate animated:NO];
    
    // 通常デザインの吹き出し
    //MMAnnotationView *annotationView = [[MMAnnotationView alloc] initWithMapView:mapView coordinate:mapView.centerCoordinate];
    // フラットデザインの吹き出し
     MMAnnotationView *annotationView = [[MMFlatAnnotationView alloc] initWithMapView:mapView coordinate:mapView.centerCoordinate];
    // 吹き出し内のボタンを表示させたくない場合
    // MMAnnotationView *annotationView = [[MMAnnotationView alloc] initWithMapView:mapView coordinate:mapView.centerCoordinate useLeftAccessoryView:NO useRightAccessoryView:NO];
    
    annotationView.title = @"タイトル";
    annotationView.subtitle = @"サブタイトル";
    annotationView.rightButtonTapped = ^(MMMapView *mapView) {
        // 吹き出し内の詳細ボタンタップ時の挙動をここに書く
    };
    
    // 独自アイコンを使いたい場合
    // annotationView.image = [UIImage imageNamed:@"myicon.png"];
    // annotationView.centerOffset = CGPointMake(-21, -28); // アイコンの中心を設定
    
    // annotationViewのタッチイベントをオーバーライドしたい場合
    // annotationView.tapped = ^(MMMapView *mapView) {
    //
    // };
    
    // 吹き出し内の右側viewを適当なviewに切り替えたい場合（左側も同様）
    // annotationView.rightAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
    // [annotationView.rightAccessoryView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test)]];
    
    [mapView addAnnotation:annotationView animated:YES]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

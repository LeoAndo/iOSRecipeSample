//
//  ViewController.h
//  ch9UseMapKitDirections
//
//  Created by shoeisha on 2014/01/26.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

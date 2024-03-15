//
//  MMFixImage.h
//  MapionMaps
//
//  Created by honjo on 2013/07/02.
//  Copyright (c) 2013 Mapion Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMMapView.h"
#import "MMOverlay.h"

@interface MMFixImage : MMOverlay

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id)initWithMapView:(MMMapView *)mapView coordinate:(CLLocationCoordinate2D)coordinate image:(UIImage *)image;

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated;
- (void)updatePosition;

@end

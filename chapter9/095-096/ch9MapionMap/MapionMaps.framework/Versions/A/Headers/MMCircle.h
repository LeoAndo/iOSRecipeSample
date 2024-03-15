//
//  MMCircle.h
//  MapionMaps
//
//  Created by honjo on 12/10/23.
//  Copyright (c) 2012 Mapion Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MMOverlay.h"
#import "MMFoundation.h"

@class MMMapView;

@interface MMCircle : MMOverlay

@property (nonatomic, retain) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CLLocationCoordinate2D centerCoordinate;
@property (nonatomic, retain) UIColor *lineColor;
@property (nonatomic, retain) UIColor *fillColor;
@property (nonatomic, assign) CGFloat r;
@property (nonatomic, assign) CGFloat lineWidth;

- (id)initWithMapView:(MMMapView *)mapView centerCoordinate:(CLLocationCoordinate2D)centerCoordinate r:(CGFloat)r;
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate animated:(BOOL)animated;
- (void)setR:(CGFloat)r animated:(BOOL)animated;

@end

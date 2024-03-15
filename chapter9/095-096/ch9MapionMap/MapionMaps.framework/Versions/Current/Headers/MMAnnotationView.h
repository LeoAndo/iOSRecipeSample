//
//  MMAnnotationView.h
//  MapionMaps
//
//  Created by honjo on 12/05/16.
//  Copyright (c) 2012 Mapion Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>

@class MMMapView, SMCalloutView, SMCalloutBackgroundView;

@interface MMAnnotationView : UIImageView

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, assign) CGPoint centerOffset;
@property (nonatomic, retain) UIView *leftAccessoryView;
@property (nonatomic, retain) UIView *rightAccessoryView;
@property (nonatomic, copy) void (^leftButtonTapped)(MMMapView *mapView);
@property (nonatomic, copy) void (^rightButtonTapped)(MMMapView *mapView);
@property (nonatomic, copy) void (^tapped)(MMMapView *mapView);
@property (nonatomic, assign) CGPoint calloutOffset;
@property (nonatomic, assign) BOOL calloutAnimated;
@property (nonatomic, assign) BOOL dismissCalloutAnimated;
@property (nonatomic, assign) CGFloat marginLeft;
@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) CGFloat marginRight;
@property (nonatomic, assign) CGFloat marginBottom;
@property (nonatomic, readonly) SMCalloutView *calloutView;

- (id)initWithMapView:(MMMapView *)mapView coordinate:(CLLocationCoordinate2D)coordinate;
- (id)initWithMapView:(MMMapView *)mapView coordinate:(CLLocationCoordinate2D)coordinate useLeftAccessoryView:(BOOL)useLeftAccessoryView useRightAccessoryView:(BOOL)useRightAccessoryView;
- (void)reCalculate;
- (void)setCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated;
- (BOOL)touch;
- (void)close;

@end

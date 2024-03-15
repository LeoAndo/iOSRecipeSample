//
//  MMShape.h
//  MapionMaps
//
//  Created by honjo on 12/09/20.
//  Copyright (c) 2012 Mapion Co.,Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MMFoundation.h"
#import "MMOverlay.h"

@class MMMapView;

@interface MMShape : MMOverlay

@property (nonatomic, retain) NSString *fillRule;
@property (nonatomic, retain) NSString *lineCap;
@property (nonatomic, retain) NSString *lineJoin;

@property (nonatomic, retain) UIColor *lineColor;

@property (nonatomic, retain) UIColor *fillColor;

@property (nonatomic, assign) NSArray *lineDashLengths;
@property (nonatomic, assign) CGFloat lineDashPhase;
@property (nonatomic, assign) BOOL scaleLineDash;

@property (nonatomic, assign) float lineWidth;

@property (nonatomic, assign) BOOL scaleLineWidth;
@property (nonatomic, assign) CGFloat shadowBlur;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) BOOL enableShadow;

- (id)initWithMapView:(MMMapView *)mapView;

- (void)moveToPoint:(CGPoint)point;
- (void)moveToPoint:(CGPoint)point flush:(BOOL)flush;
- (void)moveToCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)moveToCoordinate:(CLLocationCoordinate2D)coordinate flush:(BOOL)flush;
- (void)addLineToPoint:(CGPoint)point;
- (void)addLineToPoint:(CGPoint)point flush:(BOOL)flush;
- (void)addLineToCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)addLineToCoordinate:(CLLocationCoordinate2D)coordinate flush:(BOOL)flush;

- (void)performBatchOperations:(void (^)(MMShape *aPath))block;

// ラインの場合はこれ最後に呼ばなくてもいいけどポリゴンの場合はこれを最後に呼ばないと微妙に閉じられない
- (void)closePath;

@end

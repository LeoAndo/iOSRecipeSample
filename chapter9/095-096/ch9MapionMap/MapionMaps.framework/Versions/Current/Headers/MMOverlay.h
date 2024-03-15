//
//  MMOverlay.h
//  MapionMaps
//
//  Created by honjo on 12/10/24.
//  Copyright (c) 2012 Mapion Co.,Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "MMFoundation.h"

@class MMMapView;

@interface MMOverlay : CATiledLayer

@property (nonatomic, assign) MMProjectedPoint projectedLocation;
@property (nonatomic, retain) MMMapView *mapView;
@property (nonatomic, assign) NSTimeInterval animationDuration;

- (void)setPosition:(CGPoint)position animated:(BOOL)animated;

@end

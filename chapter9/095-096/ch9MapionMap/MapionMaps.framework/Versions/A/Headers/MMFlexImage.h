//
//  MMFlexibleImage.h
//  MapionMaps
//
//  Created by honjo on 2013/07/02.
//  Copyright (c) 2013 Mapion Co.,Ltd. All rights reserved.
//

#import "MMFixImage.h"

@interface MMFlexImage : MMFixImage

- (id)initWithMapView:(MMMapView *)mapView coordinate:(CLLocationCoordinate2D)coordinate image:(UIImage *)image originZoom:(float)originZoom;

@end

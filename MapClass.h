//
//  MapClass.h
//  TenStar
//
//  Created by Dharasis on 14/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MapClass : NSObject<MKMapViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic)  MKMapView *mapView;
@property(strong,nonatomic) CLLocationManager *locationManager;
-(MKMapView*)createMapView:(CGRect)frame;
-(CLLocationManager*)createLocationMgr;
@end

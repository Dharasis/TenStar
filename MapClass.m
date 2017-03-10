//
//  MapClass.m
//  TenStar
//
//  Created by Dharasis on 14/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "MapClass.h"

@implementation MapClass{
        MKPointAnnotation *point;
        MKAnnotationView *annotationView;
        CLLocationCoordinate2D currentUserLocation;
    
}


-(MKMapView*)createMapView:(CGRect)frame{

_mapView   = [[MKMapView alloc]init];
_mapView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);




_mapView.mapType = MKMapTypeSatellite;






    return _mapView;


}

-(CLLocationManager*)createLocationMgr{
    
    self.locationManager = [[CLLocationManager alloc] init];
    

    
    
    
//    //  we have to setup the location maanager with permission in later iOS versions
//    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [self.locationManager requestWhenInUseAuthorization];
//    }
    
    //[[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
   // [[self locationManager] startUpdatingLocation];

    
    return  self.locationManager;
    
}

//-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    
//    
//    
//    //    self.locationManager = [[CLLocationManager alloc] init];
//    //
//    
//    
//}
//
//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//    
//    
//    
//    
//    currentUserLocation =   userLocation.coordinate;
//    
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
//    (currentUserLocation, 8500, 8500);
//    [[self mapView] setRegion:region animated:YES];
//    
//    
//    point   = [[MKPointAnnotation alloc] init];
//    point.coordinate = userLocation.coordinate;
//    
//    [self.mapView addAnnotation:point];
//    
//    
//}
//
//
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//    
//    annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
//    //annotationView=[[MKPinAnnotationView alloc]init];
//    annotationView.canShowCallout = YES;
//    
//    
//    
//    
//    return annotationView;
//}
//
//-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
//    
//}
//
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    
//}
//-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
//    
//}
//-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
//    
//}
//
//



@end

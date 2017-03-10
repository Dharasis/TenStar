//
//  MaintenanceVC.h
//  TenStar
//
//  Created by Dharasis on 09/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapClass.h"
#import "SelectDoorVC.h"
#import "APIHelperClass.h"
#import "SVProgressHUD.h"
@interface MaintenanceVC : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property(strong,nonatomic)UIImageView *backGrndImageView;
@property(strong,nonatomic) UIImageView *navigationBar;
@property (strong, nonatomic)  MKMapView *mapView;
@property(strong,nonatomic) CLLocationManager *locationManager;
@property(strong,nonatomic)UIView *mapUserView;
@property(strong,nonatomic)NSMutableArray* jsonAr;
@property(strong,nonatomic)NSMutableArray *completedDoor;
@property(strong,nonatomic)UIImageView * chooseDirection;
@property(strong,nonatomic)UIImageView * chooseRegion;


@end

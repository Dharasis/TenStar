//
//  SelectDoorVC.h
//  TenStar
//
//  Created by Dharasis on 14/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapClass.h"
#import "APIHelperClass.h"
#import "CustomAnnotation.h"
#import "Maintenance_1.h"

@interface SelectDoorVC : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property(nonatomic,strong)UIImageView* backGrndImageView;
@property(nonatomic,strong)UIImageView* navigationBar;
@property (strong, nonatomic)  MKMapView *mapView;
@property(strong,nonatomic) CLLocationManager *locationManager;
@property(strong,nonatomic)NSMutableArray * jsonAr;
@property(strong,nonatomic)NSString* direction;
@property(strong,nonatomic) UILabel *totolDoor;
@property(strong,nonatomic) UILabel *completedDoor;
@property(strong,nonatomic) UILabel *incompletedDoor;
@property(strong,nonatomic)UIView* mapUserView;
@property(strong,nonatomic)UIView *footer;
@property(strong,nonatomic)NSMutableArray *completedDoorAr;
@property(strong,nonatomic) UIImageView* footerView;

-(id)init:(NSString*)direction;
@end

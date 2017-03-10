//
//  DashBoardVC.h
//  TenStar
//
//  Created by Dharasis on 09/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaintenanceVC.h"
#import "DoorListVC.h"
#import "AddDoorVC.h"
#import "NotificationVC.h"
#import <CoreLocation/CoreLocation.h>
#import "APIHelperClass.h"
#import "SVProgressHUD.h"
@interface DashBoardVC : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    float longitude,latitude;
    NSString* city,*Country;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    BOOL sosCall;
    int serviceCode;
    NSString* serviceREsponse;
    
}

@property(strong,nonatomic)UIImageView *backGrndImageView;
@property(strong,nonatomic)UITableView *dashboardTableView;
@property(strong,nonatomic) UIImageView *navigationBar;

@end

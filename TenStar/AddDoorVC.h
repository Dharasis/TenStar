//
//  AddDoorVC.h
//  TenStar
//
//  Created by Dharasis on 31/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapClass.h"
#import "APIHelperClass.h"
#import "SVProgressHUD.h"
#import "NSObject+ChooseRegionManager.h"
@interface AddDoorVC : UIViewController<UITextFieldDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIImageView* profileImageView;
@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,strong)UITextField* doorName,*region,*mobNo,*doorAddressLongitude,*clientID,*supervisorID,*customDoorId,*doorAddressLatitude,*regionTxtFld,*doorAddress;
@property(nonatomic,strong)UIButton* addDoorBtn;
@property(nonatomic,strong)MKMapView* mapView;
@property(strong,nonatomic) CLLocationManager *locationManager;
@property(strong,nonatomic) MKPointAnnotation *annot;
@end

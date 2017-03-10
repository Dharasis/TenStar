//
//  UpdateDoorVC.h
//  TenStar
//
//  Created by Dharasis on 8/2/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapClass.h"
#import "APIHelperClass.h"
#import "SVProgressHUD.h"

@interface UpdateDoorVC : UIViewController<UITextFieldDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UITextField* doorNameTxtFld,*regionTxtFld,*mobileNoTxtFld,*addressTxtFld,*clientTxtFld,*supervisorTxtFld,*customDoorId;
@property(nonatomic,strong)UIImageView* doorPhotoEdit;
@property(nonatomic,strong)UIImageView* doorNameEditLine,*regionEditLine,*mobileNoEditLine,*addressEditLine,*clientEditLine,*supervisorEditLine,*customDoorIdEditLine;
@property(nonatomic,strong)MKMapView* mapView;
@property(strong,nonatomic) CLLocationManager *locationManager;
@property(strong,nonatomic) MKPointAnnotation *annot;
@property(nonatomic,strong)UIButton *editBtn,*updateDoorBtn;
@property(nonatomic,strong)UIScrollView* scrollView;
@property(assign)int doorID;
-(id)init:(int)doorID;

@end

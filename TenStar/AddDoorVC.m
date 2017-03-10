//
//  AddDoorVC.m
//  TenStar
//
//  Created by Dharasis on 31/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "AddDoorVC.h"

@interface AddDoorVC (){
    UIImageView *headView;
     float textFieldWidth;
    UIView *backPopUp,*letsGetStartedPopUp;
    UITextField* currentTextField;
    UIButton *doneBtn;
    UIPickerView* clientIdPicker,*supervisorPicker,*regionPicker;
    NSMutableArray* jsonAr,*jsonArSupervisor;
    NSArray * regionAr;
    int ClientID,SupervisorId;
    NSString* serviceResponse;
    int responseCode;
    
    
}

@end

@implementation AddDoorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    [self fetchCleintDetails];
    
    [self fetchSupervisorDetails];

    
    regionAr = [NSArray arrayWithObjects:@"North",@"East",@"South",@"West", nil];
    
    
    if(screenRect.size.height<=568){
        textFieldWidth=40;
    }else{
        textFieldWidth=50;
    }
  UIImageView*  _navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
    _navigationBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
    _navigationBar.userInteractionEnabled=YES;
    [self.view addSubview:_navigationBar];
    
    headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, screenRect.size.width, 155)];
    headView.userInteractionEnabled=YES;
    headView.image = [UIImage imageNamed:@"AddDoorHeader"];
    [self.view addSubview:headView];

    
        //Adding Menu Option
    
    UIButton *menuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"ProfileBackBtn"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(20,10,20,30);
    [ menuBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:menuBtn];
    
    
    //profilePicture
    _profileImageView = [[UIImageView alloc]init];
    _profileImageView.frame=CGRectMake(headView.frame.size.width/2
                                       -50, headView.frame.size.height/2-70, 100, 100);
    _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width/2;
    _profileImageView.userInteractionEnabled=YES;
    _profileImageView.clipsToBounds=YES;
    [_profileImageView setBackgroundColor:[UIColor whiteColor]];
    [headView addSubview:_profileImageView];
    
    
    //Camera Button
    UIButton *cameraBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [cameraBtn setBackgroundImage:[UIImage imageNamed:@"CameraBtn"] forState:UIControlStateNormal];
    cameraBtn.frame = CGRectMake(_profileImageView.frame.origin.x+_profileImageView.frame.size.width-30,_profileImageView.frame.origin.y+_profileImageView.frame.size.height-30,30,30);
    [ cameraBtn addTarget:self action:@selector(cameraActn) forControlEvents:UIControlEventTouchUpInside];
    [headView
     addSubview:cameraBtn];
    
    
    //Scroll View
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headView.frame.origin.y+headView.frame.size.height, screenRect.size.width, screenRect.size.height-(headView.frame.origin.y+headView.frame.size.height))];
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    
    [self createUI];
    
    
    // Do any additional setup after loading the view.
}



-(void)createUI{
    
    
      NSString* fontName = FONT_NAME;
    //Add custom door  text field
    
    _customDoorId = [[UITextField alloc]init];
    _customDoorId.frame = CGRectMake(20, 10, _scrollView.frame.size.width-40, textFieldWidth);
    _customDoorId.backgroundColor=[UIColor clearColor];
    _customDoorId.delegate=self;
    _customDoorId.placeholder = @"Enter Door ID";
    _customDoorId.font = [UIFont fontWithName:fontName size:14];
    _customDoorId.textColor=[UIColor grayColor];
    _customDoorId.keyboardType = UIKeyboardTypeNumberPad;
    _customDoorId.layer.cornerRadius=5;
    _customDoorId.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    _customDoorId.leftViewMode = UITextFieldViewModeAlways;
    _customDoorId.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [_scrollView addSubview:_customDoorId];
    

    
    //Add door text field
    
    _doorName = [[UITextField alloc]init];
    _doorName.frame = CGRectMake(20, _customDoorId.frame.origin.y+_customDoorId.frame.size.height+10, _scrollView.frame.size.width-40, textFieldWidth);
    _doorName.backgroundColor=[UIColor clearColor];
    _doorName.delegate=self;
    _doorName.placeholder = @"Enter Door Name";
    _doorName.font = [UIFont fontWithName:fontName size:14];
    _doorName.textColor=[UIColor grayColor];
    _doorName.layer.cornerRadius=5;
    _doorName.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    _doorName.leftViewMode = UITextFieldViewModeAlways;
    _doorName.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [_scrollView addSubview:_doorName];
    
    
    //Add select Region Text Field
    
    _region = [[UITextField alloc]init];
    _region.frame = CGRectMake(20, _doorName.frame.origin.y+_doorName.frame.size.height+10, _scrollView.frame.size.width-40, textFieldWidth);
    _region.backgroundColor=[UIColor clearColor];
    _region.delegate=self;
    _region.placeholder = @"Select Region";
    _region.font = [UIFont fontWithName:fontName size:14];
    _region.textColor=[UIColor grayColor];
    _region.layer.cornerRadius=5;
    _region.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    _region.leftViewMode = UITextFieldViewModeAlways;
    _region.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];

   // [_scrollView addSubview:_region];
    
    
    
    //picker
    
    regionPicker = [[UIPickerView alloc]init];
    regionPicker.dataSource = self;
    regionPicker.delegate = self;
    regionPicker.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton3 = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(done3:)];
    UIToolbar *toolBar3 = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     _region.frame.size.height-50, screenRect.size.width, 50)];
    [toolBar3 setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems3 = [NSArray arrayWithObjects:
                             doneButton3, nil];
    [toolBar3 setItems:toolbarItems3];
    _region.inputView = regionPicker;
    _region.inputAccessoryView = toolBar3;
    
    
    
    
    //Resposible person Mob number
    
    _mobNo = [[UITextField alloc]init];
    _mobNo.frame = CGRectMake(20, _doorName.frame.origin.y+_doorName.frame.size.height+10, _scrollView.frame.size.width-40, textFieldWidth);
    _mobNo.backgroundColor=[UIColor clearColor];
    _mobNo.delegate=self;
    _mobNo.placeholder = @"Enter Responsible Person Mob No";
    _mobNo.font = [UIFont fontWithName:fontName size:14];
    _mobNo.textColor=[UIColor grayColor];
    _mobNo.layer.cornerRadius=5;
    _mobNo.keyboardType=UIKeyboardTypeNumberPad;
    _mobNo.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    _mobNo.leftViewMode = UITextFieldViewModeAlways;
    _mobNo.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [_scrollView addSubview:_mobNo];
    
    //Select Door Address
    
    _doorAddressLongitude = [[UITextField alloc]init];
    _doorAddressLongitude.frame = CGRectMake(20, _mobNo.frame.origin.y+_mobNo.frame.size.height+10, _scrollView.frame.size.width/2-20, textFieldWidth);
    _doorAddressLongitude.backgroundColor=[UIColor clearColor];
    _doorAddressLongitude.delegate=self;
    _doorAddressLongitude.placeholder = @"Longitude";
    _doorAddressLongitude.font = [UIFont fontWithName:fontName size:14];
    _doorAddressLongitude.textColor=[UIColor grayColor];
    _doorAddressLongitude.layer.cornerRadius=5;
    _doorAddressLongitude.keyboardType=UIKeyboardTypeDecimalPad;
    _doorAddressLongitude.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    _doorAddressLongitude.leftViewMode = UITextFieldViewModeAlways;
    _doorAddressLongitude.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [_scrollView addSubview:_doorAddressLongitude];

    
    
    _doorAddressLatitude = [[UITextField alloc]init];
    _doorAddressLatitude.frame = CGRectMake(_scrollView.frame.size.width/2+10, _mobNo.frame.origin.y+_mobNo.frame.size.height+10, _scrollView.frame.size.width/2-30, textFieldWidth);
    _doorAddressLatitude.backgroundColor=[UIColor clearColor];
    _doorAddressLatitude.delegate=self;
    _doorAddressLatitude.placeholder = @"Latitude";
    _doorAddressLatitude.font = [UIFont fontWithName:fontName size:14];
    _doorAddressLatitude.textColor=[UIColor grayColor];
    _doorAddressLatitude.layer.cornerRadius=5;
    _doorAddressLatitude.keyboardType=UIKeyboardTypeDecimalPad;
    _doorAddressLatitude.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    _doorAddressLatitude.leftViewMode = UITextFieldViewModeAlways;
    _doorAddressLatitude.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [_scrollView addSubview:_doorAddressLatitude];

    
    
    
    
    
    _doorAddress = [[UITextField alloc]init];
    _doorAddress.frame = CGRectMake(20, _doorAddressLatitude.frame.origin.y+_doorAddressLatitude.frame.size.height+10, _scrollView.frame.size.width-40, textFieldWidth);
    _doorAddress.backgroundColor=[UIColor clearColor];
    _doorAddress.delegate=self;
    _doorAddress.placeholder = @"Door Address";
    _doorAddress.enabled = NO;
    _doorAddress.font = [UIFont fontWithName:fontName size:14];
    _doorAddress.textColor=[UIColor grayColor];
    _doorAddress.layer.cornerRadius=5;
    _doorAddress.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    _doorAddress.leftViewMode = UITextFieldViewModeAlways;
    _doorAddress.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [_scrollView addSubview:_doorAddress];
    

    
    
    
    
    
    
    _regionTxtFld = [[UITextField alloc]init];
    _regionTxtFld.frame = CGRectMake(20, _doorAddress.frame.origin.y+_doorAddress.frame.size.height+10, _scrollView.frame.size.width-40, textFieldWidth);
    _regionTxtFld.backgroundColor=[UIColor clearColor];
    _regionTxtFld.delegate=self;
    _regionTxtFld.placeholder = @"Region";
    _regionTxtFld.enabled = NO;
    _regionTxtFld.font = [UIFont fontWithName:fontName size:14];
    _regionTxtFld.textColor=[UIColor grayColor];
    _regionTxtFld.layer.cornerRadius=5;
    _regionTxtFld.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    _regionTxtFld.leftViewMode = UITextFieldViewModeAlways;
    _regionTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [_scrollView addSubview:_regionTxtFld];
    
    
    
    //Client ID and Name
    
    _clientID = [[UITextField alloc]init];
    _clientID.frame = CGRectMake(20, _regionTxtFld.frame.origin.y+_regionTxtFld.frame.size.height+10, _scrollView.frame.size.width-40, textFieldWidth);
    _clientID.backgroundColor=[UIColor clearColor];
    _clientID.delegate=self;
    _clientID.placeholder = @"Select Client Id and Name";
    _clientID.font =  [UIFont fontWithName:fontName size:14];
    _clientID.textColor=[UIColor grayColor];
    _clientID.layer.cornerRadius=5;
    _clientID.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    _clientID.leftViewMode = UITextFieldViewModeAlways;
    _clientID.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [_scrollView addSubview:_clientID];
    
    
    
    
    //picker
    
    clientIdPicker = [[UIPickerView alloc]init];
    clientIdPicker.dataSource = self;
    clientIdPicker.delegate = self;
    clientIdPicker.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(done:)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     clientIdPicker.frame.size.height-50, screenRect.size.width, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    _clientID.inputView = clientIdPicker;
    _clientID.inputAccessoryView = toolBar;

    
    
    
    

    
    
    //Supervisor ID and Name
    
    _supervisorID = [[UITextField alloc]init];
    _supervisorID.frame = CGRectMake(20, _clientID.frame.origin.y+_clientID.frame.size.height+10, _scrollView.frame.size.width-40, textFieldWidth);
    _supervisorID.backgroundColor=[UIColor clearColor];
    _supervisorID.delegate=self;
    _supervisorID.placeholder = @"Select Supervisor Id and Name";
    _supervisorID.font =  [UIFont fontWithName:fontName size:14];
    _supervisorID.textColor=[UIColor grayColor];
    _supervisorID.layer.cornerRadius=5;
    _supervisorID.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    _supervisorID.leftViewMode = UITextFieldViewModeAlways;
    _supervisorID.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [_scrollView addSubview:_supervisorID];
    
    
    
    
    //picker
    
    supervisorPicker = [[UIPickerView alloc]init];
    supervisorPicker.dataSource = self;
    supervisorPicker.delegate = self;
    supervisorPicker.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton2 = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(done2:)];
    UIToolbar *toolBar2 = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     supervisorPicker.frame.size.height-50, screenRect.size.width, 50)];
    [toolBar2 setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems2 = [NSArray arrayWithObjects:
                             doneButton2, nil];
    [toolBar2 setItems:toolbarItems2];
    _supervisorID.inputView = supervisorPicker;
    _supervisorID.inputAccessoryView = toolBar2;
    
    

    
    //Add door Btn
    
    
    _addDoorBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addDoorBtn.frame=CGRectMake(20, _supervisorID.frame.origin.y+self.supervisorID.frame.size.height+10, _scrollView.frame.size.width-40, textFieldWidth);
    [_addDoorBtn setBackgroundImage:[UIImage imageNamed:@"AddDoorBtnNormal"] forState:UIControlStateNormal];
    [_addDoorBtn addTarget:self action:@selector(addDoorAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_addDoorBtn];
    
    
    
    float sizeOfContent = 0;
    UIView *lLast = [_scrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=20;
    sizeOfContent = wd+ht;
    _scrollView.contentSize=CGSizeMake(screenRect.size.width,sizeOfContent+offset);
    [self registerForKeyboardNotifications];

    
}

#pragma mark- back button Action
-(void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark- Text field delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    currentTextField=textField;
    
    
    if(textField==_doorAddressLongitude){
      //  [self addDoorAddress];
    
       
        
        
        
    }
   // if(textField==_clientID)}
        //[self fetchCleintDetails];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(![_doorAddressLongitude.text isEqual:@""] && ![_doorAddressLatitude.text isEqual:@""])
    {
        _regionTxtFld.text = [self manageRegion:[_doorAddressLongitude.text floatValue] latitude:[_doorAddressLatitude.text floatValue] ];
        
        [self fetchAddress:[_doorAddressLatitude.text floatValue] longitude:[_doorAddressLongitude.text floatValue]];

    }
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

#pragma mark- fetch Client Details
-(void)fetchCleintDetails{

    
    jsonAr = [[NSMutableArray alloc]init];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [APIHelperClass fetchClientDetails :^(NSDictionary * jsonResponseMsg){
            
            
            //NSLog(@"Respose: %@",jsonResponseMsg);
            jsonAr=[jsonResponseMsg objectForKey:@"data"];
            
            
                 dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        

        
        dispatch_async(dispatch_get_main_queue(), ^{
            
       
            

                       
            
            
            
            
            
            
            
        });
        
    });

    
    
    
}



#pragma mark- fetch Client Details
-(void)fetchSupervisorDetails{
    
    
    jsonArSupervisor = [[NSMutableArray alloc]init];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [APIHelperClass fetchSupervisorDetails :^(NSDictionary * jsonResponseMsg){
            
            
            //NSLog(@"Respose: %@",jsonResponseMsg);
            jsonArSupervisor=[jsonResponseMsg objectForKey:@"data"];
            
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [SVProgressHUD dismiss];
            
            
            
            
            
            
            
            
            
        });
        
    });
    
    
    
    
}



#pragma mark- Add door address
-(void)addDoorAddress{
    
    backPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    backPopUp.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:backPopUp];
    
    letsGetStartedPopUp=[[UIView alloc]init];
    letsGetStartedPopUp.frame = CGRectMake(10, 800, self.view.frame.size.width-20, self.view.frame.size.height-20);
    letsGetStartedPopUp.layer.cornerRadius=6.0f;
    letsGetStartedPopUp.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1];
    letsGetStartedPopUp.clipsToBounds = YES;
    letsGetStartedPopUp.layer.shadowColor = [UIColor blackColor].CGColor;
    letsGetStartedPopUp.layer.shadowOffset = CGSizeMake(-2, 2);
    letsGetStartedPopUp.layer.shadowOpacity = 3;
    letsGetStartedPopUp.layer.shadowRadius = 15;
    letsGetStartedPopUp.layer.shadowPath = [UIBezierPath bezierPathWithRect:letsGetStartedPopUp.bounds].CGPath;
    
    [backPopUp addSubview:letsGetStartedPopUp];
    
    
    
    //[self.view insertSubview:letsGetStartedPopUp atIndex:2];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 60, self.view.frame.size.width-60, self.view.frame.size.height-100);
        backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    }completion:nil];
    
    
    
       
   
    _mapView   = [[MKMapView alloc]init];
    _mapView.frame=CGRectMake(0, 0, letsGetStartedPopUp.frame.size.width, letsGetStartedPopUp.frame.size.height);
    
    _mapView.delegate=self;
    
    
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(23.8859, 45.0792);
    
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
    ( _mapView.centerCoordinate, 1000000, 1000000);
  
    
    [_mapView setRegion:region animated:YES];
    [letsGetStartedPopUp addSubview:_mapView];
    
    
    
    
    
    UILabel *header=[[UILabel alloc]init];
    header.frame = CGRectMake(00,0,  letsGetStartedPopUp.frame.size.width, 30);
    
    
    header.text=@"Mark Door on Map";
    header.font=[UIFont systemFontOfSize:16];
    header.textColor=[UIColor colorWithRed:(CGFloat)98/255 green:(CGFloat)89/255 blue:(CGFloat)163/255 alpha:(CGFloat)1];
    header.textAlignment = NSTextAlignmentCenter;
    [_mapView addSubview:header];

    
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate=self;
    
    
    //  we have to setup the location maanager with permission in later iOS versions
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    //[[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
   // [[self locationManager] startUpdatingLocation];

    
    
    doneBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneBtn.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-40,letsGetStartedPopUp.frame.size.width, 40);
    [doneBtn setTitle:@"Done!" forState:UIControlStateNormal];
    doneBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [doneBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)98/255 green:(CGFloat)89/255 blue:(CGFloat)163/255 alpha:(CGFloat)1]];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
    doneBtn.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:doneBtn];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(selectDoorAddAction:)];
    [letsGetStartedPopUp addGestureRecognizer:tap];
    
    
    
    _annot = [[MKPointAnnotation alloc] init];
    [self.mapView addAnnotation:_annot];
 
  
}




#pragma mark- done Action
-(void)fetchAddress : (float)latitude longitude:(float)longitude{
    
    
    
    
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude: latitude longitude:longitude]; //insert your coordinates
    
    [ceo reverseGeocodeLocation:loc
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  CLPlacemark *placemark = [placemarks objectAtIndex:0];
                  if (placemark) {
                      
                      
                     // NSLog(@"placemark %@",placemark);
                      //String to hold address
                      NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                     
                    
                      //Print the location to console
                      NSLog(@"I am currently at %@",locatedAt);
                      
                      _doorAddress.text = locatedAt;
                      
                      
                  }
                  else {
                      _doorAddress.text = @"Not Found";
                  }
              }];
    
//     _doorAddress.text = [NSString stringWithFormat:@"Lon: %f,Lat: %f",_annot.coordinate.longitude,_annot.coordinate.latitude];
//    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
       
       

        
        
     
        
        
    }];
    
   
    
    
}




#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    if(pickerView==clientIdPicker)
    
        return [jsonAr count];
    
    
    else if (pickerView==supervisorPicker)
        
        return [jsonArSupervisor count];
    
    else if (pickerView==regionPicker)
        return regionAr.count;
    
    return 0;
    
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
    if(pickerView==clientIdPicker)
    [_clientID setText:[NSString stringWithFormat:@"%@ ,ID - %@",[[jsonAr objectAtIndex:row] objectForKey:@"Name"],[[jsonAr objectAtIndex:row] objectForKey:@"ID"]]];
    else if (pickerView==supervisorPicker)
           [_supervisorID setText:[NSString stringWithFormat:@"%@ ,ID - %@",[[jsonArSupervisor objectAtIndex:row] objectForKey:@"Name"],[[jsonArSupervisor objectAtIndex:row] objectForKey:@"ID"]]];
        
    else if (pickerView==regionPicker)
        [_region setText:[regionAr objectAtIndex:row]];

}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    NSString * title;
  
    
    if(pickerView==clientIdPicker){
 title = [NSString stringWithFormat:@"%@ ,ID - %@",[[jsonAr objectAtIndex:row] objectForKey:@"Name"],[[jsonAr objectAtIndex:row] objectForKey:@"ID"]]
        ;
        ClientID = [[[jsonAr objectAtIndex:row] objectForKey:@"ID"]intValue];
    }
    else if (pickerView==supervisorPicker){
        title = [NSString stringWithFormat:@"%@ ,ID - %@",[[jsonArSupervisor objectAtIndex:row] objectForKey:@"Name"],[[jsonArSupervisor objectAtIndex:row] objectForKey:@"ID"]]
        ;

    SupervisorId = [[[jsonArSupervisor objectAtIndex:row] objectForKey:@"ID"]intValue];
    }
    else if (pickerView==regionPicker)
       return  [regionAr objectAtIndex:row];
 
    
    return title;
}

#pragma mark- Picker done button Action

-(void)done:(UIButton*)sender{
    
    [_clientID resignFirstResponder];
    
}

-(void)done3:(UIButton*)sender{
    
    [_region resignFirstResponder];
    
}

-(void)done2:(UIButton*)sender{
    
    [_supervisorID resignFirstResponder];
    
}

- (void)selectDoorAddAction:(UIGestureRecognizer *)gestureRecognizer
{

    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
       _annot.coordinate = touchMapCoordinate;
    
}


#pragma mark- Add door Action
-(void)addDoorAction{
    
    
    
    
    
    NSLog(@"lat: %f  & long: %f",_annot.coordinate.latitude,_annot.coordinate.longitude);
    
//    [_addDoorBtn setBackgroundImage:[UIImage imageNamed:@"AddNewDoorSelected"] forState:UIControlStateNormal];
    if(UIImagePNGRepresentation(_profileImageView.image)==nil)
        [self.view makeToast:@"Door  Photo MIssing"];
   else if([_customDoorId.text isEqual:@""])
        [self.view makeToast:@" Door ID Missing"];
   else if([_doorName.text isEqual:@""])
        [self.view makeToast:@"Door Name missing!"];
    else if ([_mobNo.text isEqual:@""])
        [self.view makeToast:@"Mobile No missing!"];
    else if([_doorAddressLongitude.text isEqual:@""])
        [self.view makeToast:@"Door Longotude Missing!"];
    else if([_doorAddressLatitude.text isEqual:@""])
        [self.view makeToast:@"Door Latitude Missing!"];
    else if([_regionTxtFld.text isEqual:@"" ])
        [self.view makeToast:@"Region missing!"];
    else if([_clientID.text isEqual:@""])
        [self.view makeToast:@"Client Name & Id Missing!"];
    else if([_supervisorID.text isEqual:@""])
        [self.view makeToast:@"Supervisor Name & Id Missing!"];
    else{
        [_addDoorBtn setBackgroundImage:[UIImage imageNamed:@"AddNewDoorSelected"] forState:UIControlStateNormal];
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [SVProgressHUD show];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            
//            NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_ID"];
//           
          
            int regionNo;
           if([_regionTxtFld.text isEqual:@"East"])
               regionNo=1;
            else if ([_regionTxtFld.text isEqual:@"West"])
                regionNo=2;
            else  if([_regionTxtFld.text isEqual:@"North"])
              regionNo=3;
              else  if([_regionTxtFld.text isEqual:@"South"])
                  regionNo=4;
            else if ([_regionTxtFld.text isEqual:@"Central"])
                    regionNo=5;
            
            
            
            [APIHelperClass addDoorService:self.profileImageView.image region:[NSString stringWithFormat:@"%d",regionNo] door_short_name:_doorName.text address:_doorAddress.text responsible_person_ph_no:_mobNo.text latitude:_doorAddressLatitude.text longitude:_doorAddressLongitude.text supervisor_id:[NSString stringWithFormat:@"%d",SupervisorId] client_id:[NSString stringWithFormat:@"%d",ClientID] customDoorId:_customDoorId.text : ^(NSDictionary* responseMsg)    {
                
                
                
                
                serviceResponse=[responseMsg objectForKey:@"message"];
                responseCode=[[responseMsg objectForKey:@"code"]intValue];
                
                
                
                dispatch_semaphore_signal(semaphore);
                
            }];
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                
                [self.view makeToast:serviceResponse];
                
                
                if(responseCode==200){
                    
                    _annot=nil;
                    _customDoorId.text=@"";
                    _doorAddressLongitude.text=@"";
                    _regionTxtFld.text=@"";
                    _doorAddress.text=@"";
                    _doorAddressLatitude.text=@"";
                    _doorName.text=@"";
                    _region.text=@"";
                    _clientID.text=@"";
                    _supervisorID.text=@"";
                    _profileImageView.image= [UIImage imageNamed:@""];
                    _mobNo.text=@"";
                    
                    [self.addDoorBtn setBackgroundImage:[UIImage imageNamed:@"AddDoorBtnNormal"] forState:UIControlStateNormal];
                    

                    
                    
                }else{
                    [self.addDoorBtn setBackgroundImage:[UIImage imageNamed:@"AddDoorBtnNormal"] forState:UIControlStateNormal];
                    
                    
                }
                
                
            });
            
        });
        
        
        
        
        
    }
    

    
    
}

#pragma mark- Register keyboard notification
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, currentTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, currentTextField.frame.origin.y-kbSize.height);
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
}


// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}



-(void)cameraActn{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:picker animated:YES completion:NULL];
}


#pragma mark- Image Picker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profileImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


-(NSData*)convertDoorImage:(UIImage*)doorImage{
    
    return UIImageJPEGRepresentation(doorImage, .3);

    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // allow backspace
    if (!string.length)
    {
        return YES;
    }
    
    
    // verify max length has not been exceeded
    NSString *proposedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if(textField==_mobNo){
        if (proposedText.length > 10) // 4 was chosen for SSN verification
        {
            return NO;
        }
    }
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

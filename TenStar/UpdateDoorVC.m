//
//  UpdateDoorVC.m
//  TenStar
//
//  Created by Dharasis on 8/2/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "UpdateDoorVC.h"
#import "UIImageView+WebCache.h"

@interface UpdateDoorVC (){
    UIImageView *headView;
    float textFieldWidth;
      BOOL isTextFieldSelected;
    NSMutableArray* jsonAr,*jsonArSupervisor;
     UITextField* currentTextField;
     UIView *backPopUp,*letsGetStartedPopUp;
      UIButton *doneBtn;
    NSString* serviceResponse;
    NSDictionary  *jsonDict;
    int responseCode;
     int ClientID,SupervisorId;
    float lattitude,longitude;
     UIPickerView* clientIdPicker,*supervisorPicker,*regionPicker;
    NSArray * region;

}

@end

@implementation UpdateDoorVC




-(id)init{
    if (self = [super init]){
        
    }
    
    return self;
}
-(id)init:(int)doorID{
    if (self = [super init]){
        
        
        _doorID = doorID;
        NSLog(@"Door ID %d",_doorID);
        
    }
    
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
}

-(void)viewDidUnload{
    [_scrollView removeFromSuperview];
    [_doorPhotoEdit removeFromSuperview];
}
-(void)viewDidDisappear:(BOOL)animated{
    
    
    [super viewDidDisappear:YES];
    
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    region = [NSArray arrayWithObjects:@"North",@"East",@"South",@"West", nil];
    
    
    
    [self fetchCleintDetails];
    
    [self fetchSupervisorDetails];
    
    
    
    
    
    
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        
        [APIHelperClass fetchDoorDetailService:[NSString stringWithFormat:@"%d",self.doorID] success: ^(NSDictionary* responseMsg)    {
            
            
            
            
            serviceResponse=[responseMsg objectForKey:@"message"];
            responseCode=[[responseMsg objectForKey:@"code"]intValue];
            
            
            
            if(responseCode==200){
                
                jsonDict = [responseMsg objectForKey:@"data"];
                
                
            }
            
            
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
            
            
            
            
            [self createUI];
            
            if(serviceResponse == nil)
                [self.view makeToast:@"Something Went Wrong!!"];
            
            
            [self.view makeToast:serviceResponse];
            
            
        });
        
        
        
    });

    
    

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
    headView.image = [UIImage imageNamed:@"UpdateDoorHeader"];
    [self.view addSubview:headView];
    
    
    //Adding Menu Option
    
    UIButton *menuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"ProfileBackBtn"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(20,10,20,30);
    [ menuBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:menuBtn];
    
    
    //[self createUI];
    
    
    // Do any additional setup after loading the view.
}
-(void)cameraActn{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark- done Action
-(void)doneActn{
    
    
    
    
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude: _annot.coordinate.latitude longitude:_annot.coordinate.longitude]; //insert your coordinates
    
    [ceo reverseGeocodeLocation:loc
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  CLPlacemark *placemark = [placemarks objectAtIndex:0];
                  if (placemark) {
                      
                      
                      // NSLog(@"placemark %@",placemark);
                      //String to hold address
                      NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                      
                      
                      //Print the location to console
                      NSLog(@"I am currently at %@",locatedAt);
                      
                      _addressTxtFld.text = locatedAt;
                  }
                  else {
                      NSLog(@"Could not locate");
                  }
              }];
    
    //     _doorAddress.text = [NSString stringWithFormat:@"Lon: %f,Lat: %f",_annot.coordinate.longitude,_annot.coordinate.latitude];
    //
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        [backPopUp removeFromSuperview];
        [_mapView removeFromSuperview];
        
        
        
        
        
    }];
    
    
    
    
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
    
    if(textField==_mobileNoTxtFld){
        if (proposedText.length > 10) // 4 was chosen for SSN verification
        {
            return NO;
        }
    }
    return YES;
}


#pragma mark- Image Picker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.doorPhotoEdit.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
#pragma mark- Back Button Action
-(void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- Create UI
-(void)createUI{
    //profilePicture
    _doorPhotoEdit = [[UIImageView alloc]init];
    _doorPhotoEdit.frame=CGRectMake(headView.frame.size.width/2
                                    -50, headView.frame.size.height/2-70, 100, 100);
    _doorPhotoEdit.layer.cornerRadius = _doorPhotoEdit.frame.size.width/2;
    _doorPhotoEdit.userInteractionEnabled=YES;
    _doorPhotoEdit.clipsToBounds=YES;
    [_doorPhotoEdit setBackgroundColor:[UIColor whiteColor]];
    [headView addSubview:_doorPhotoEdit];
    
    

    
    
    NSURL *url;
    if([jsonDict  objectForKey:@"shop_picture"] != [NSNull null])
    {
        NSString *urlStr = [[jsonDict  objectForKey:@"shop_picture"] objectAtIndex:0];
        url = [NSURL URLWithString:urlStr];
    }
    // doctorsImg.image = [UIImage imageNamed:@"doctor_img.png"];
    
    
    
    [_doorPhotoEdit sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultDoorPic"]];
    
    

    
    //Camera Button
    UIButton *cameraBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [cameraBtn setBackgroundImage:[UIImage imageNamed:@"CameraBtn"] forState:UIControlStateNormal];
    cameraBtn.frame = CGRectMake(_doorPhotoEdit.frame.origin.x+_doorPhotoEdit.frame.size.width-30,_doorPhotoEdit.frame.origin.y+_doorPhotoEdit.frame.size.height-30,30,30);
    [ cameraBtn addTarget:self action:@selector(cameraActn) forControlEvents:UIControlEventTouchUpInside];
    [headView
     addSubview:cameraBtn];
    
    
    //Scroll View
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headView.frame.origin.y+headView.frame.size.height, screenRect.size.width, screenRect.size.height-(headView.frame.origin.y+headView.frame.size.height))];
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    
    
    
    //Custom Door ID
    
    UILabel * customDoorIdLbl = [[UILabel alloc]initWithFrame:CGRectMake(30, 0,150, 30)];
    customDoorIdLbl.text=@"Door Id";
    [_scrollView addSubview:customDoorIdLbl];
    //Door Name text field
    _customDoorId = [[UITextField alloc]init];
    _customDoorId.frame = CGRectMake(30, customDoorIdLbl.frame.origin.y+customDoorIdLbl.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    if([jsonDict  objectForKey:@"custom_door_id"]!=[NSNull null])
    _customDoorId.text=[jsonDict objectForKey:@"custom_door_id"];
    _customDoorId.backgroundColor=[UIColor clearColor];
    _customDoorId.enabled=NO;
    _customDoorId.delegate=self;
    _customDoorId.keyboardType=UIKeyboardTypeNumberPad;
    _customDoorId.font = [UIFont systemFontOfSize:13];
    _customDoorId.textColor=[UIColor grayColor];
    [_scrollView addSubview:_customDoorId];
    //separator line
    UIView *separator =[[UIView alloc]initWithFrame:CGRectMake(30, _customDoorId.frame.origin.y+_customDoorId.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    //Door name editting line
    _customDoorIdEditLine = [[UIImageView alloc]init];
    _customDoorIdEditLine.frame = CGRectMake(30, _customDoorId.frame.origin.y+_customDoorId.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _customDoorIdEditLine.hidden=YES;
    _customDoorIdEditLine.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_customDoorIdEditLine];
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, customDoorIdLbl.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=1000;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];
    

    
    
    
    //Name Label
    UILabel * doorNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(30, separator.frame.origin.y+10,100, 30)];
    doorNameLbl.text=@"Door Name";
    [_scrollView addSubview:doorNameLbl];
    //Door Name text field
    _doorNameTxtFld = [[UITextField alloc]init];
    _doorNameTxtFld.frame = CGRectMake(30, doorNameLbl.frame.origin.y+doorNameLbl.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    if([jsonDict  objectForKey:@"door_short_name"]!=[NSNull null])
        _doorNameTxtFld.text=[jsonDict objectForKey:@"door_short_name"];
    _doorNameTxtFld.backgroundColor=[UIColor clearColor];
    _doorNameTxtFld.enabled=NO;
    _doorNameTxtFld.delegate=self;
    _doorNameTxtFld.font = [UIFont systemFontOfSize:13];
    _doorNameTxtFld.textColor=[UIColor grayColor];
    [_scrollView addSubview:_doorNameTxtFld];
    //separator line
    separator =[[UIView alloc]initWithFrame:CGRectMake(30, _doorNameTxtFld.frame.origin.y+_doorNameTxtFld.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    //Door name editting line
    _doorNameEditLine = [[UIImageView alloc]init];
    _doorNameEditLine.frame = CGRectMake(30, _doorNameTxtFld.frame.origin.y+_doorNameTxtFld.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _doorNameEditLine.hidden=YES;
    _doorNameEditLine.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_doorNameEditLine];
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, doorNameLbl.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=100;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];
    
    
    
    //Region Label
    UILabel * regionLbl = [[UILabel alloc]initWithFrame:CGRectMake(30, separator.frame.origin.y+10, 150, 30)];
    regionLbl.text=@"Region";
    [_scrollView addSubview:regionLbl];
    //Region text field
    _regionTxtFld = [[UITextField alloc]init];
    _regionTxtFld.frame = CGRectMake(30, regionLbl.frame.origin.y+regionLbl.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    _regionTxtFld.backgroundColor=[UIColor clearColor];
    
    
    
    if([jsonDict objectForKey:@"region"]!=[NSNull null])
        
    {
        if([[jsonDict objectForKey:@"region"] isEqual:@"1"])
        
        
        _regionTxtFld.text=@"East";
    
    else if ([[jsonDict objectForKey:@"region"]isEqual:@"2"])

      _regionTxtFld.text=@"West";
    else if ([[jsonDict objectForKey:@"region"] isEqual:@"3"])
        
        _regionTxtFld.text=@"North";
    
        
    else if ([[jsonDict objectForKey:@"region"]isEqual:@"4"])
        
        _regionTxtFld.text=@"South";

    
    }
    
    _regionTxtFld.enabled=NO;
    _regionTxtFld.delegate=self;
    _regionTxtFld.font = [UIFont systemFontOfSize:13];
    _regionTxtFld.textColor=[UIColor grayColor];
    [_scrollView addSubview:_regionTxtFld];
    //separator line
   separator =[[UIView alloc]initWithFrame:CGRectMake(30, _regionTxtFld.frame.origin.y+_regionTxtFld.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    //region editting line
    _regionEditLine = [[UIImageView alloc]init];
    _regionEditLine.frame = CGRectMake(30, _regionTxtFld.frame.origin.y+_regionTxtFld.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _regionEditLine.hidden=YES;
    _regionEditLine.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_regionEditLine];
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, regionLbl.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=200;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];
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
                                      _regionTxtFld.frame.size.height-50, screenRect.size.width, 50)];
    [toolBar3 setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems3 = [NSArray arrayWithObjects:
                              doneButton3, nil];
    [toolBar3 setItems:toolbarItems3];
    _regionTxtFld.inputView = regionPicker;
    _regionTxtFld.inputAccessoryView = toolBar3;
    
    

    
    
    //mobile Label
    UILabel * mobileNo = [[UILabel alloc]initWithFrame:CGRectMake(30, separator.frame.origin.y+10, 200, 30)];
    mobileNo.text=@"Responsible Person Mob No";
    mobileNo.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:mobileNo];
    //mobile text field
    _mobileNoTxtFld = [[UITextField alloc]init];
     if([jsonDict objectForKey:@"responsible_person_ph_no"]!=[NSNull null])
    _mobileNoTxtFld.text=[jsonDict objectForKey:@"responsible_person_ph_no"];
    
    _mobileNoTxtFld.frame = CGRectMake(30, mobileNo.frame.origin.y+mobileNo.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    _mobileNoTxtFld.backgroundColor=[UIColor clearColor];
    _mobileNoTxtFld.enabled=NO;
    _mobileNoTxtFld.delegate=self;
    _mobileNoTxtFld.keyboardType=UIKeyboardTypeNumberPad;
    _mobileNoTxtFld.font = [UIFont systemFontOfSize:12];
    _mobileNoTxtFld.textColor=[UIColor grayColor];
    [_scrollView addSubview:_mobileNoTxtFld];
     //separator line
    separator =[[UIView alloc]initWithFrame:CGRectMake(30, _mobileNoTxtFld.frame.origin.y+_mobileNoTxtFld.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    //mobile editting line
    _mobileNoEditLine = [[UIImageView alloc]init];
    _mobileNoEditLine.frame = CGRectMake(30, _mobileNoTxtFld.frame.origin.y+_mobileNoTxtFld.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _mobileNoEditLine.hidden=YES;
    _mobileNoEditLine.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_mobileNoEditLine];
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, mobileNo.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=300;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];
    

    
    
    
    //Address Label
    UILabel * address = [[UILabel alloc]initWithFrame:CGRectMake(30, separator.frame.origin.y+10, 190, 30)];
    address.text=@"Address";
    [_scrollView addSubview:address];
    //Address text field
    _addressTxtFld = [[UITextField alloc]init];
    _addressTxtFld.frame = CGRectMake(30, address.frame.origin.y+address.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    _addressTxtFld.backgroundColor=[UIColor clearColor];
    _addressTxtFld.enabled=NO;
    if([jsonDict  objectForKey:@"address"]!=[NSNull null])
        _addressTxtFld.text=[jsonDict objectForKey:@"address"];
    _addressTxtFld.delegate=self;
    _addressTxtFld.font = [UIFont systemFontOfSize:13];
    _addressTxtFld.textColor=[UIColor grayColor];
    [_scrollView addSubview:_addressTxtFld];
    
    
    lattitude = [[jsonDict objectForKey:@"latitude"]floatValue];
    longitude = [[jsonDict objectForKey:@"longitude"]floatValue];

    
    //separator line
    separator =[[UIView alloc]initWithFrame:CGRectMake(30, _addressTxtFld.frame.origin.y+_addressTxtFld.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    //mobile editting line
    _addressEditLine = [[UIImageView alloc]init];
    _addressEditLine.frame = CGRectMake(30, _addressTxtFld.frame.origin.y+_addressTxtFld.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _addressEditLine.hidden=YES;
    _addressEditLine.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_addressEditLine];
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, address.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=400;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];
    
    
    
    
    
    
    //Address Label
    UILabel * clientId = [[UILabel alloc]initWithFrame:CGRectMake(30, separator.frame.origin.y+10, 190, 30)];
    clientId.text=@"Client ID & Name";
    [_scrollView addSubview:clientId];
    //Address text field
    _clientTxtFld = [[UITextField alloc]init];
    _clientTxtFld.frame = CGRectMake(30, clientId.frame.origin.y+clientId.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    _clientTxtFld.backgroundColor=[UIColor clearColor];
    if([jsonDict  objectForKey:@"client_id"]!=[NSNull null])
        _clientTxtFld.text= [NSString stringWithFormat:@"%@ ,ID - %@",[jsonDict  objectForKey:@"client_name"],[jsonDict  objectForKey:@"client_id"]];
    _clientTxtFld.enabled=NO;
    _clientTxtFld.delegate=self;
    
    
    ClientID = [[jsonDict  objectForKey:@"client_id"]intValue];
    
    
    _clientTxtFld.font = [UIFont systemFontOfSize:13];
    _clientTxtFld.textColor=[UIColor grayColor];
    [_scrollView addSubview:_clientTxtFld];
    //separator line
    separator =[[UIView alloc]initWithFrame:CGRectMake(30, _clientTxtFld.frame.origin.y+_clientTxtFld.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    //mobile editting line
    _clientEditLine = [[UIImageView alloc]init];
    _clientEditLine.frame = CGRectMake(30, _clientTxtFld.frame.origin.y+_clientTxtFld.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _clientEditLine.hidden=YES;
    _clientEditLine.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_clientEditLine];
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, clientId.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=500;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];
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
                                     _clientTxtFld.frame.size.height-50, screenRect.size.width, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    _clientTxtFld.inputView = clientIdPicker;
    _clientTxtFld.inputAccessoryView = toolBar;

    
    
    
    
    //Supervisor Label
    UILabel * supervisor = [[UILabel alloc]initWithFrame:CGRectMake(30, separator.frame.origin.y+10, 190, 30)];
    supervisor.text=@"Supervisor ID & Name";
    [_scrollView addSubview:supervisor];
    //Supervisor text field
    _supervisorTxtFld = [[UITextField alloc]init];
    _supervisorTxtFld.frame = CGRectMake(30, supervisor.frame.origin.y+supervisor.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    _supervisorTxtFld.backgroundColor=[UIColor clearColor];
    _supervisorTxtFld.enabled=NO;
    
    if([jsonDict  objectForKey:@"supervisor_id"]!=[NSNull null])
        _supervisorTxtFld.text= [NSString stringWithFormat:@"%@ ,ID - %@",[jsonDict  objectForKey:@"supervisor_name"],[jsonDict  objectForKey:@"supervisor_id"]];
    
    
    SupervisorId = [[jsonDict  objectForKey:@"supervisor_id"]intValue];

    
    _supervisorTxtFld.delegate=self;
    _supervisorTxtFld.font = [UIFont systemFontOfSize:13];
    _supervisorTxtFld.textColor=[UIColor grayColor];
    [_scrollView addSubview:_supervisorTxtFld];
    //separator line
    separator =[[UIView alloc]initWithFrame:CGRectMake(30, _supervisorTxtFld.frame.origin.y+_supervisorTxtFld.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    //mobile editting line
    _supervisorEditLine = [[UIImageView alloc]init];
    _supervisorEditLine.frame = CGRectMake(30, _supervisorTxtFld.frame.origin.y+_supervisorTxtFld.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _supervisorEditLine.hidden=YES;
    _supervisorEditLine.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_supervisorEditLine];
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, supervisor.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=600;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];
    
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
                                      _supervisorTxtFld.frame.size.height-50, screenRect.size.width, 50)];
    [toolBar2 setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems2 = [NSArray arrayWithObjects:
                              doneButton2, nil];
    [toolBar2 setItems:toolbarItems2];
    _supervisorTxtFld.inputView = supervisorPicker;
    _supervisorTxtFld.inputAccessoryView = toolBar2;

    
    
    
    
    //textField Edit Btn
    _updateDoorBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _updateDoorBtn.frame=CGRectMake(_scrollView.frame.size.width/2-50, _supervisorTxtFld.frame.origin.y+_supervisorTxtFld.frame.size.height+20, 100, 40);
    [_updateDoorBtn setBackgroundImage:[UIImage imageNamed:@"updateProfileBtn_deselect"] forState:UIControlStateNormal];
    [_updateDoorBtn addTarget:self action:@selector(updateDoorAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_updateDoorBtn];
    
    
    
    float sizeOfContent = 0;
    UIView *lLast = [_scrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=20;
    sizeOfContent = wd+ht;
    _scrollView.contentSize=CGSizeMake(screenRect.size.width,sizeOfContent+offset);
    
    [self registerForKeyboardNotifications];

    
}


#pragma mark- Add door Action
-(void)updateDoorAction{
        
        //    [_addDoorBtn setBackgroundImage:[UIImage imageNamed:@"AddNewDoorSelected"] forState:UIControlStateNormal];
    if([_customDoorId.text isEqual:@""])
        [self.view makeToast:@"Custom ID missing!"];
        else if([_doorNameTxtFld.text isEqual:@""])
            [self.view makeToast:@"Door Name missing!"];
        else if([_regionTxtFld.text isEqual:@"" ])
            [self.view makeToast:@"Region missing!"];
        else if ([_mobileNoTxtFld.text isEqual:@""])
            [self.view makeToast:@"Mobile No missing!"];
        else if([_addressTxtFld.text isEqual:@""])
            [self.view makeToast:@"Door Address Missing!"];
        else if([_clientTxtFld.text isEqual:@""])
            [self.view makeToast:@"Client Name & Id Missing!"];
        else if([_supervisorTxtFld.text isEqual:@""])
            [self.view makeToast:@"Supervisor Name & Id Missing!"];
        else{
            [_updateDoorBtn setBackgroundImage:[UIImage imageNamed:@"updateProfileBtn_deselect"] forState:UIControlStateNormal];
            
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            [SVProgressHUD show];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
               
                
                
                int regionNo;
                if([_regionTxtFld.text isEqual:@"East"])
                    regionNo=1;
                else if ([_regionTxtFld.text isEqual:@"West"])
                    regionNo=2;
                else  if([_regionTxtFld.text isEqual:@"North"])
                    regionNo=3;
                else  if([_regionTxtFld.text isEqual:@"South"])
                    regionNo=4;
                
                
                
                [APIHelperClass updateDoorService :self.doorPhotoEdit.image region:[NSString stringWithFormat:@"%d",regionNo] door_short_name:_doorNameTxtFld.text address:_addressTxtFld.text responsible_person_ph_no:_mobileNoTxtFld.text latitude:[NSString stringWithFormat:@"%f",lattitude] longitude:[NSString stringWithFormat:@"%f",longitude] supervisor_id:[NSString stringWithFormat:@"%d",SupervisorId] client_id: [NSString stringWithFormat:@"%d",ClientID] door_id: [NSString stringWithFormat:@"%d",_doorID] customId:_customDoorId.text   : ^(NSDictionary* responseMsg)
                
                
                {
                    
                    
                    
                    
                    serviceResponse=[responseMsg objectForKey:@"message"];
                    responseCode=[[responseMsg objectForKey:@"code"]intValue];
                    
                    
                    
                    dispatch_semaphore_signal(semaphore);
                    
                }];
                
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    if(serviceResponse == nil)
                        [self.view makeToast:@"Something Went Wrong!!"];
                    
                    
                    
                    [self.view makeToast:serviceResponse];
                    
                    
                    if(responseCode==200){
                        
                        
                    }else{
                        [self.updateDoorBtn setBackgroundImage:[UIImage imageNamed:@"updateProfileBtn_deselect"] forState:UIControlStateNormal];
                        
                        
                    }
                    
                    
                });
                
            });
            
            
            
            
            
        }
        
        
        
        
    }
    



#pragma mark- fetch Client Details
-(void)fetchCleintDetails{
    
    
    jsonAr = [[NSMutableArray alloc]init];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    //[SVProgressHUD show ];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [APIHelperClass fetchClientDetails :^(NSDictionary * jsonResponseMsg){
            
            
            //NSLog(@"Respose: %@",jsonResponseMsg);
            jsonAr=[jsonResponseMsg objectForKey:@"data"];
            
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
       //     [SVProgressHUD dismiss];
            
            
            
            
            
            
            
            
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



// Call this method somewhere in your view controller setup code.
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



#pragma mark- Text field Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    currentTextField=textField;
    
    
    if(textField==_addressTxtFld)
        [self addDoorAddress];

}
#pragma mark- text field delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}



- (void)selectDoorAddAction:(UIGestureRecognizer *)gestureRecognizer
{
    
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    _annot.coordinate = touchMapCoordinate;
    
    
    lattitude = touchMapCoordinate.latitude;
    longitude = touchMapCoordinate.longitude;
    
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
    [[self locationManager] startUpdatingLocation];
    
    
    
    doneBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneBtn.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-40,letsGetStartedPopUp.frame.size.width, 40);
    [doneBtn setTitle:@"Done!" forState:UIControlStateNormal];
    doneBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [doneBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)98/255 green:(CGFloat)89/255 blue:(CGFloat)163/255 alpha:(CGFloat)1]];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneActn) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:doneBtn];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(selectDoorAddAction:)];
    [letsGetStartedPopUp addGestureRecognizer:tap];
    
    
    
    _annot = [[MKPointAnnotation alloc] init];
    [self.mapView addAnnotation:_annot];
    
    
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
        return region.count;
    
    return 0;
    
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
    if(pickerView==clientIdPicker){
        [_clientTxtFld setText:[NSString stringWithFormat:@"%@ ,ID - %@",[[jsonAr objectAtIndex:row] objectForKey:@"Name"],[[jsonAr objectAtIndex:row] objectForKey:@"ID"]]];
        
        ClientID = [[[jsonAr objectAtIndex:row] objectForKey:@"ID"]intValue];
        
    }
    else if (pickerView==supervisorPicker){
        [_supervisorTxtFld setText:[NSString stringWithFormat:@"%@ ,ID - %@",[[jsonArSupervisor objectAtIndex:row] objectForKey:@"Name"],[[jsonArSupervisor objectAtIndex:row] objectForKey:@"ID"]]];
        
        SupervisorId = [[[jsonArSupervisor objectAtIndex:row] objectForKey:@"ID"]intValue];
    }
    
    else if (pickerView==regionPicker)
        [_regionTxtFld setText:[region objectAtIndex:row]];
    
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
        return  [region objectAtIndex:row];
    
    
    return title;
}

#pragma mark- Picker done button Action

-(void)done:(UIButton*)sender{
    
    [_clientTxtFld resignFirstResponder];
    
}

-(void)done3:(UIButton*)sender{
    
    [_regionTxtFld resignFirstResponder];
    
}

-(void)done2:(UIButton*)sender{
    
    [_supervisorTxtFld resignFirstResponder];
    
}
#pragma mark - Edit action
-(void)editAction:(UIButton*)sender{
    
    
    
    if(isTextFieldSelected==NO){
              [sender setBackgroundImage:[UIImage imageNamed:@"profileOkBtn"] forState:UIControlStateNormal];
        
        
        if(sender.tag==1000){
            
            _customDoorId.enabled=YES;
            _customDoorIdEditLine.hidden=NO;
            
        }else if(sender.tag==200){
            
            _regionTxtFld.enabled=YES;
            _regionEditLine.hidden=NO;
        } else if(sender.tag==300){
            
            _mobileNoTxtFld.enabled=YES;
            _mobileNoEditLine.hidden=NO;
        }else if(sender.tag==400){
            
            _addressTxtFld.enabled=YES;
            _addressEditLine.hidden=NO;
        }
        else if(sender.tag==500){
            
            _clientTxtFld.enabled=YES;
            _clientEditLine.hidden=NO;
        }else if(sender.tag==600){
            
            _supervisorTxtFld.enabled=YES;
            _supervisorEditLine.hidden=NO;
        }
        
        
        
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
        
        
        if(sender.tag==1000){
            
            _customDoorId.enabled=NO;
            _customDoorIdEditLine.hidden=YES;
            
        }else if(sender.tag==100){
            
            _doorNameTxtFld.enabled=NO;
            _doorNameEditLine.hidden=YES;
            
        }else if(sender.tag==200){
            
            _regionTxtFld.enabled=NO;
            _regionEditLine.hidden=YES;
        }else if(sender.tag==300){
            
            _mobileNoTxtFld.enabled=NO;
            _mobileNoEditLine.hidden=YES;
        }else if(sender.tag==400){
            
            _addressTxtFld.enabled=NO;
            _addressEditLine.hidden=YES;
        }else if(sender.tag==500){
            
            _clientTxtFld.enabled=NO;
            _clientEditLine.hidden=YES;
        }else if(sender.tag==600){
            
            _supervisorTxtFld.enabled=NO;
            _supervisorEditLine.hidden=YES;
        }
        
        


    }
    
         isTextFieldSelected = !isTextFieldSelected;
      
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

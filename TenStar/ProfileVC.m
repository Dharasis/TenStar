//
//  ProfileVC.m
//  TenStar
//
//  Created by Dharasis on 14/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "ProfileVC.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
@interface ProfileVC ()
{
    BOOL isTextFieldSelected;
    UITextField* currentTextField;
    NSString* serviceResponse;
    int responseCode;
    NSDictionary* profileDict;
    UIPickerView *genderPicker;
    NSArray *pickerArray;
    UIImageView *headView;

}
@end

@implementation ProfileVC




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    
  headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, screenRect.size.width, 155)];
    headView.userInteractionEnabled=YES;
    headView.image = [UIImage imageNamed:@"EditProfileHead"];
    [self.view addSubview:headView];

    //Adding Menu Option
    
    UIButton *menuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"MenuBtn"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(20,10,30,30);
    [ menuBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:menuBtn];

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_ID"];
        
             [APIHelperClass fetchProfileService:userId  success:^(NSDictionary* responseMsg)    {
            
            
            
            profileDict = responseMsg;
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
            
            [self createUI];
            

            
            
            if(responseCode==200){
                
                
        
                
                
            }
            
            
        });
        
    });
    
    
    
    
      // Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
   
    serviceResponse=nil;
    
}

#pragma mark- Create UI
-(void)createUI{
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    
    
    pickerArray=[NSArray arrayWithObjects:@"Male",@"Female", nil];
    
    
    
    //profilePicture
    _profileImageView = [[UIImageView alloc]init];
    _profileImageView.frame=CGRectMake(headView.frame.size.width/2
                                       -50, headView.frame.size.height/2-50, 100, 100);
    _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width/2;
    _profileImageView.userInteractionEnabled=YES;
    _profileImageView.clipsToBounds=YES;
    [_profileImageView setBackgroundColor:[UIColor whiteColor]];
    [headView addSubview:_profileImageView];
    
    
    if([[profileDict objectForKey:@"data"] objectForKey:@"image"]==[NSNull null] || [[[profileDict objectForKey:@"data"] objectForKey:@"image"]isEqual:@""]){
        _profileImageView.image = [UIImage imageNamed:@"notificationUserPhoto"];
    }
    else{
        
        NSString *urlStr = [[profileDict objectForKey:@"data"] objectForKey:@"image"];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        // doctorsImg.image = [UIImage imageNamed:@"doctor_img.png"];
        
        
        
        [_profileImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"notificationUserPhoto"]];
        
    }
    
    
    
    
    
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
    
    NSString* fontName = FONT_NAME;

    
    //Name Label
    UILabel * nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 30)];
    nameLbl.text=@"Name";
    nameLbl.font = [UIFont fontWithName:fontName size:15];
    [_scrollView addSubview:nameLbl];

    
    //name text field
    
    _nameTxtField = [[UITextField alloc]init];
    _nameTxtField.frame = CGRectMake(30, nameLbl.frame.origin.y+nameLbl.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    if([[profileDict objectForKey:@"data"] objectForKey:@"name"])
    _nameTxtField.text=[[profileDict objectForKey:@"data"] objectForKey:@"name"];
    _nameTxtField.backgroundColor=[UIColor clearColor];
    _nameTxtField.enabled=NO;
    _nameTxtField.delegate=self;
    _nameTxtField.font = [UIFont fontWithName:fontName size:15];
    _nameTxtField.textColor=[UIColor grayColor];
    [_scrollView addSubview:_nameTxtField];
    
    
    
    
    //separator line
    UIView *separator =[[UIView alloc]initWithFrame:CGRectMake(30, _nameTxtField.frame.origin.y+_nameTxtField.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    
    
    
    //name editting line
    _nameEditting = [[UIImageView alloc]init];
    _nameEditting.frame = CGRectMake(30, _nameTxtField.frame.origin.y+_nameTxtField.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _nameEditting.hidden=YES;
    _nameEditting.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_nameEditting];
    
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, nameLbl.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=100;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];
    
    
    
    
    //----
    //mobile Label
    UILabel * mobileNo = [[UILabel alloc]initWithFrame:CGRectMake(30, separator.frame.origin.y+10, 150, 30)];
    mobileNo.text=@"Mobile Number";
    mobileNo.font = [UIFont fontWithName:fontName size:15];
    [_scrollView addSubview:mobileNo];
    
    
    //mobile text field
    
    _mobileTxtField = [[UITextField alloc]init];
    _mobileTxtField.frame = CGRectMake(30, mobileNo.frame.origin.y+mobileNo.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    
    if([[profileDict objectForKey:@"data"] objectForKey:@"contact_no"] != [NSNull null])
    _mobileTxtField.text=[[profileDict objectForKey:@"data"] objectForKey:@"contact_no"];
    _mobileTxtField.backgroundColor=[UIColor clearColor];
    _mobileTxtField.font = [UIFont fontWithName:fontName size:14];
    _mobileTxtField.enabled=NO;
    _mobileTxtField.delegate=self;
    _mobileTxtField.keyboardType=UIKeyboardTypeNumberPad;
    _mobileTxtField.textColor=[UIColor grayColor];
    [_scrollView addSubview:_mobileTxtField];
    
    
    
    
    //separator line
   separator =[[UIView alloc]initWithFrame:CGRectMake(30, _mobileTxtField.frame.origin.y+_mobileTxtField.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    
    
    
    //name editting line
    _mobileEditting = [[UIImageView alloc]init];
    _mobileEditting.frame = CGRectMake(30, _mobileTxtField.frame.origin.y+_mobileTxtField.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _mobileEditting.hidden=YES;
    _mobileEditting.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_mobileEditting];
    
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, mobileNo.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=200;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];
    
    
    
    
    //----
    //mobile Label
    UILabel * optionalMob = [[UILabel alloc]initWithFrame:CGRectMake(30, separator.frame.origin.y+10, 190, 30)];
    optionalMob.text=@"Optional Mobile Number";
    optionalMob.font = [UIFont fontWithName:fontName size:15];
    [_scrollView addSubview:optionalMob];
    
    
    //mobile text field
    
    _optionalMobTxtField = [[UITextField alloc]init];
    _optionalMobTxtField.frame = CGRectMake(30, optionalMob.frame.origin.y+optionalMob.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    if([[profileDict objectForKey:@"data"] objectForKey:@"contact_no"] != [NSNull null])

    _optionalMobTxtField.text=[[profileDict objectForKey:@"data"] objectForKey:@"contact_no"];
    _optionalMobTxtField.backgroundColor=[UIColor clearColor];
    _optionalMobTxtField.font = [UIFont fontWithName:fontName size:15];
    _optionalMobTxtField.enabled=NO;
    _optionalMobTxtField.delegate=self;
    _optionalMobTxtField.keyboardType=UIKeyboardTypeNumberPad;
    _optionalMobTxtField.textColor=[UIColor grayColor];
    [_scrollView addSubview:_optionalMobTxtField];
    
    
    
    
    //separator line
    separator =[[UIView alloc]initWithFrame:CGRectMake(30, _optionalMobTxtField.frame.origin.y+_optionalMobTxtField.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    
    
    
    //name editting line
    _optionalMobileEditting = [[UIImageView alloc]init];
    _optionalMobileEditting.frame = CGRectMake(30, _optionalMobTxtField.frame.origin.y+_optionalMobTxtField.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _optionalMobileEditting.hidden=YES;
    _optionalMobileEditting.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_optionalMobileEditting];
    
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, optionalMob.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=300;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];
    
    
    
    
    //----
    //mobile Label
    UILabel * age = [[UILabel alloc]initWithFrame:CGRectMake(30, separator.frame.origin.y+10, 80, 30)];
    age.text=@"Age";
    age.font = [UIFont fontWithName:fontName size:15];
    [_scrollView addSubview:age];
    
    
    //mobile text field
    
    _ageTxtField = [[UITextField alloc]init];
    _ageTxtField.frame = CGRectMake(30, age.frame.origin.y+age.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    if([[profileDict objectForKey:@"data"] objectForKey:@"age"] != [NSNull null])

    _ageTxtField.text=[[profileDict objectForKey:@"data"] objectForKey:@"age"];
    _ageTxtField.backgroundColor=[UIColor clearColor];
    _ageTxtField.font = [UIFont fontWithName:fontName size:15];
    _ageTxtField.enabled=NO;
    _ageTxtField.delegate=self;
    _ageTxtField.keyboardType=UIKeyboardTypeNumberPad;
    _ageTxtField.textColor=[UIColor grayColor];
    [_scrollView addSubview:_ageTxtField];
    
    
    
    
    //separator line
    separator =[[UIView alloc]initWithFrame:CGRectMake(30, _ageTxtField.frame.origin.y+_ageTxtField.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    
    
    
    //name editting line
    _ageEditting = [[UIImageView alloc]init];
    _ageEditting.frame = CGRectMake(30, _ageTxtField.frame.origin.y+_ageTxtField.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _ageEditting.hidden=YES;
    _ageEditting.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_ageEditting];
    
    
    
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, age.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=400;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];

    
    
    
    //----
    //mobile Label
    UILabel * gender = [[UILabel alloc]initWithFrame:CGRectMake(30, separator.frame.origin.y+10, 100, 30)];
    gender.text=@"Gender";
    gender.font = [UIFont fontWithName:fontName size:15];
    [_scrollView addSubview:gender];
    
    
    //mobile text field
    
    _genderTxtField = [[UITextField alloc]init];
    _genderTxtField.frame = CGRectMake(30, gender.frame.origin.y+gender.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    if([[profileDict objectForKey:@"data"] objectForKey:@"gender"] != [NSNull null])

    _genderTxtField.text=[[profileDict objectForKey:@"data"] objectForKey:@"gender"];
    _genderTxtField.backgroundColor=[UIColor clearColor];
    _genderTxtField.font = [UIFont fontWithName:fontName size:15];
    _genderTxtField.enabled=NO;
    _genderTxtField.delegate=self;
    _genderTxtField.textColor=[UIColor grayColor];
    [_scrollView addSubview:_genderTxtField];
    
    
    //picker
    
    genderPicker = [[UIPickerView alloc]init];
    genderPicker.dataSource = self;
    genderPicker.delegate = self;
    genderPicker.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(done:)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     genderPicker.frame.size.height-50, screenRect.size.width, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    _genderTxtField.inputView = genderPicker;
    _genderTxtField.inputAccessoryView = toolBar;

    
    //separator line
    separator =[[UIView alloc]initWithFrame:CGRectMake(30, _genderTxtField.frame.origin.y+_genderTxtField.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    
    
    
    //name editting line
    _genderEditting = [[UIImageView alloc]init];
    _genderEditting.frame = CGRectMake(30, _genderTxtField.frame.origin.y+_genderTxtField.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _genderEditting.hidden=YES;
    _genderEditting.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_genderEditting];
    
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, gender.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=500;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];

    
    
    
    //----
    //mobile Label
    UILabel * address = [[UILabel alloc]initWithFrame:CGRectMake(30, separator.frame.origin.y+10, 190, 30)];
    address.text=@"Address";
    address.font = [UIFont fontWithName:fontName size:15];
    [_scrollView addSubview:address];
    
    
    //mobile text field
    
    _addressTxtField = [[UITextView alloc]init];
    _addressTxtField.frame = CGRectMake(30, address.frame.origin.y+address.frame.size.height-10, _scrollView.frame.size.width-100, 30);
    if([[profileDict objectForKey:@"data"] objectForKey:@"address"] != [NSNull null])

    _addressTxtField.text=[[profileDict objectForKey:@"data"] objectForKey:@"address"];
    _addressTxtField.backgroundColor=[UIColor clearColor];
    _addressTxtField.font = [UIFont fontWithName:fontName size:15];
    _addressTxtField.editable=NO;
    _addressTxtField.keyboardType=UIKeyboardTypeEmailAddress;
    _addressTxtField.delegate=self;
    _addressTxtField.textColor=[UIColor grayColor];
    [_scrollView addSubview:_addressTxtField];
    
    
    
    //name editting line
    _addressEditting = [[UIImageView alloc]init];
    _addressEditting.frame = CGRectMake(30, _addressTxtField.frame.origin.y+_addressTxtField.frame.size.height-5, _scrollView.frame.size.width-60, 2);
    _addressEditting.hidden=YES;
    _addressEditting.image=[UIImage imageNamed:@"edittingSeparator"];
    [_scrollView addSubview:_addressEditting];
    
    //textField Edit Btn
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame=CGRectMake(_scrollView.frame.size.width-60, address.frame.origin.y, 30, 30);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
    _editBtn.tag=600;
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_editBtn];

    //separator line
    separator =[[UIView alloc]initWithFrame:CGRectMake(30, _addressTxtField.frame.origin.y+_addressTxtField.frame.size.height, _scrollView.frame.size.width-60, 1)];
    separator.backgroundColor=[UIColor lightGrayColor];
    [_scrollView addSubview:separator];
    

    
    
    
    
    //textField Edit Btn
    _updateProfileBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _updateProfileBtn.frame=CGRectMake(_scrollView.frame.size.width/2-50, _addressTxtField.frame.origin.y+_addressTxtField.frame.size.height+20, 100, 40);
    [_updateProfileBtn setBackgroundImage:[UIImage imageNamed:@"updateProfileBtn_deselect"] forState:UIControlStateNormal];
    [_updateProfileBtn addTarget:self action:@selector(updateProfileAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_updateProfileBtn];

    
    
    float sizeOfContent = 0;
    UIView *lLast = [_scrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=20;
    sizeOfContent = wd+ht;
    _scrollView.contentSize=CGSizeMake(screenRect.size.width,sizeOfContent+offset);

    [self registerForKeyboardNotifications];
    
}


#pragma mark- update profile Action
-(void)updateProfileAction{
    
    if([_nameTxtField.text isEqual:@""])
        [self.view makeToast:@"Name missing!"];
    else if([_mobileTxtField.text isEqual:@"" ])
        [self.view makeToast:@"Mobile Number missing!"];
    else if ([_ageTxtField.text isEqual:@""])
        [self.view makeToast:@"Age missing!"];
    else if([_genderTxtField.text isEqual:@""])
        [self.view makeToast:@"Gender Missing!"];
    else if([_addressTxtField.text isEqual:@""])
        [self.view makeToast:@"Address Missing!"];
    else{
          [_updateProfileBtn setBackgroundImage:[UIImage imageNamed:@"updateProfileBtn_deselect"] forState:UIControlStateNormal];
        [SVProgressHUD show];
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_ID"];
            
            [APIHelperClass updateProfileService:_nameTxtField.text mobile:_mobileTxtField.text gender:_genderTxtField.text age:_ageTxtField.text contact_no:_optionalMobTxtField.text address:_addressTxtField.text userId:userId  success:^(NSDictionary* responseMsg)    {
                
                
                
                
                serviceResponse=[responseMsg objectForKey:@"message"];
                responseCode=[[responseMsg objectForKey:@"code"]intValue];
                
                
                
                dispatch_semaphore_signal(semaphore);
                
            }];
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
                
                [self.view makeToast:serviceResponse];
                
                
                if(responseCode==200){
                        //_annot=nil;
                    
                }else{
                    [self.updateProfileBtn setBackgroundImage:[UIImage imageNamed:@"updateProfileBtn_deselect"] forState:UIControlStateNormal];
                    
                    
                }
                
                
            });
            
        });
        
        
        
        
        
    }
    
    

        
        
    
}

#pragma mark- text field delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  
    [textField resignFirstResponder];
    return YES;
    
}

#pragma mark-Text View Delelgates
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
      if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}



#pragma mark- Text field Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    currentTextField=textField;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    
      return YES;
}
#pragma mark - Edit action
-(void)editAction:(UIButton*)sender{
    
    
    
    if(isTextFieldSelected==NO){
         [sender setBackgroundImage:[UIImage imageNamed:@"profileOkBtn"] forState:UIControlStateNormal];
        
        
        if(sender.tag==100){
            
            _nameTxtField.enabled=YES;
            _nameEditting.hidden=NO;
            
        }else if(sender.tag==200){
         
            _mobileTxtField.enabled=YES;
            _mobileEditting.hidden=NO;
        }
        else if(sender.tag==300){
            
            _optionalMobTxtField.enabled=YES;
            _optionalMobileEditting.hidden=NO;
        }else if(sender.tag==400){
            
            _ageTxtField.enabled=YES;
            _ageEditting.hidden=NO;
        }else if(sender.tag==500){
            
            _genderTxtField.enabled=YES;
            _genderEditting.hidden=NO;
        }else if(sender.tag==600){
            
            _addressTxtField.editable=YES;
            _addressEditting.hidden=NO;
        }
        

        
        
        
    }else{
        
        [sender setBackgroundImage:[UIImage imageNamed:@"profileEditBtn"] forState:UIControlStateNormal];
        
        if(sender.tag==100){
            
            _nameTxtField.enabled=NO;
            _nameEditting.hidden=YES;
            
        }else if(sender.tag==200){
            
            _mobileTxtField.enabled=NO;
            _mobileEditting.hidden=YES;
        }else if(sender.tag==300){
            
            _optionalMobTxtField.enabled=NO;
            _optionalMobileEditting.hidden=YES;
        }else if(sender.tag==400){
            
            _ageTxtField.enabled=NO;
            _ageEditting.hidden=YES;
        }else if(sender.tag==500){
            
            _genderTxtField.enabled=NO;
            _genderEditting.hidden=YES;
        }else if(sender.tag==600){
            
            _addressTxtField.editable=NO;
            _addressEditting.hidden=YES;
        }
        

        
        
    }
    
    isTextFieldSelected = !isTextFieldSelected;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- back Button
-(void)backButtonAction{
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"toggleMenuVisibility" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"toggleMenuVisibility" object:nil];
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


#pragma mark- Image Picker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profileImageView.image = chosenImage;
    
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_ID"];
        
        
    
        
        [APIHelperClass uploadProfilePhoto:chosenImage user_id:userId  : ^(NSDictionary* responseMsg)    {
            
            
            
            
            serviceResponse=[responseMsg objectForKey:@"message"];
            responseCode=[[responseMsg objectForKey:@"code"]intValue];
            
            
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            if(serviceResponse == nil)
                [self.view makeToast:@"Something Went Wrong!!"];
            

            [self.view makeToast:serviceResponse];
            
            
            if(responseCode==200){
                
                
            }else{
                
            }
            
            [picker dismissViewControllerAnimated:YES completion:NULL];

            
        });
        
    });
    
    

    
    
    
    
    
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


#pragma mark- Camera Button Action

-(void)cameraActn{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    [_genderTxtField setText:[pickerArray objectAtIndex:row]];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

#pragma mark- Picker done button Action

-(void)done:(UIButton*)sender{
    
    [_genderTxtField resignFirstResponder];
    
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
    
    if(textField==_ageTxtField){
    if (proposedText.length > 2) // 4 was chosen for SSN verification
    {
               return NO;
    }
    }else if(textField==_mobileTxtField){
        if (proposedText.length > 10) // 4 was chosen for SSN verification
        {
            return NO;
        }
    }else if (textField==_optionalMobTxtField){
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

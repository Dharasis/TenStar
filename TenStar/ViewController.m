//
//  ViewController.m
//  TenStar
//
//  Created by Dharasis on 25/06/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "ViewController.h"
#import "RootViewController.h"


@interface ViewController ()
{
    UITextField* currentTextField;
}
@end

@implementation ViewController

{
    
    BOOL loginClicked;
    NSString* serviceResponse;
    int responseCode;
    float textFieldWidth;
        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    for (NSString *family in [UIFont familyNames]){
//        NSLog(@"Family name: %@", family);
//        for (NSString *fontName in [UIFont fontNamesForFamilyName:family]) {
//            NSLog(@"    >Font name: %@", fontName);
//        }
//    }
    
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView*  _navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
    _navigationBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
    _navigationBar.userInteractionEnabled=YES;
    [self.view addSubview:_navigationBar];
    
    if(screenRect.size.height<=568){
        textFieldWidth=40;
    }else{
        textFieldWidth=50;
    }
    
    
    NSLog(@"Width %f  Height %f",screenRect.size.width,screenRect.size.height);
    
    //Header View
    
    self.headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0,20, screenRect.size.width, screenRect.size.height/2-130)];
    self.headerView.image=[UIImage imageNamed:@"SideMenuImage"];
    [self.view addSubview:self.headerView];

    
    
    
    
    //Login Menu Button
    
    UIButton *loginMenuBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    if(screenRect.size.width>=414 && screenRect.size.height>=736)
        loginMenuBtn.frame=CGRectMake(screenRect.size.width-110, self.headerView.frame.size.height-30, 50, 40);
    else if (screenRect.size.width>=375 && screenRect.size.height>=667)
        loginMenuBtn.frame=CGRectMake(screenRect.size.width-100, self.headerView.frame.size.height-30, 50, 40);
    else
        loginMenuBtn.frame=CGRectMake(screenRect.size.width-100, self.headerView.frame.size.height-30, 50, 40);
    
    
    loginMenuBtn.backgroundColor=[UIColor clearColor];
    [loginMenuBtn addTarget:self action:@selector(loginMenuBtnActn) forControlEvents:UIControlEventTouchUpInside];
  //  [self.view addSubview:loginMenuBtn];
    
    
    

    
    
    //signUp Menu Button
    
    UIButton *signUpMenuBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    if(screenRect.size.width>=414 && screenRect.size.height>=736)
        signUpMenuBtn.frame=CGRectMake(60, self.headerView.frame.size.height-30, 70, 40);
    else if(screenRect.size.width>=375 && screenRect.size.height>=667)
        signUpMenuBtn.frame=CGRectMake(60, self.headerView.frame.size.height-30, 60, 40);
    else
        signUpMenuBtn.frame=CGRectMake(50, self.headerView.frame.size.height-20, 60, 40);
    
    
    
    signUpMenuBtn.backgroundColor=[UIColor clearColor];
    [signUpMenuBtn addTarget:self action:@selector(signUpMenuBtnActn) forControlEvents:UIControlEventTouchUpInside];
  //  [self.view addSubview:signUpMenuBtn];
    

   
    
    
    
    
    
    
    //Login View is Displayed first
    
    loginClicked=YES;

    
    [self createLoginView];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}




#pragma mark- Sign Up View
-(void)createSignUpView{
    
    
    //Scroll View
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _headerView.frame.origin.y+_headerView.frame.size.height, screenRect.size.width, screenRect.size.height-(_headerView.frame.origin.y+_headerView.frame.size.height))];
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    

    
    //SignUp View
    self.signUpView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height-self.headerView.frame.size.height)];
    [self.signUpView setBackgroundColor:[UIColor clearColor]];
    [_scrollView addSubview:self.signUpView];
    
    
    
    //Down Arrow Image
    
    UIImageView *downArrow=[[UIImageView alloc]init];
    
    if(screenRect.size.width<=320)
        
          downArrow.frame=CGRectMake(70, -1, 20, 17);
        else
        downArrow.frame=CGRectMake(80, -1, 20, 17);
    downArrow.image=[UIImage imageNamed:@"downarrow"];
  //  [self.signUpView addSubview:downArrow];
    
    //User name Text Field
    
    self.userNameTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10,20, self.signUpView.frame.size.width-20, textFieldWidth)];
    self.userNameTxtFld.layer.cornerRadius=5;
    self.userNameTxtFld.delegate=self;
    self.userNameTxtFld.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    self.userNameTxtFld.placeholder=@" User Name";
    self.userNameTxtFld.leftViewMode = UITextFieldViewModeAlways;
    self.userNameTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    
    [self.signUpView addSubview:self.userNameTxtFld];
    
    
    
    //Email text Field
    
    self.emailTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10,self.userNameTxtFld.frame.origin.y+self.userNameTxtFld.frame.size.height+10, self.signUpView.frame.size.width-20, textFieldWidth)];
    self.emailTxtFld.delegate=self;
    self.emailTxtFld.layer.cornerRadius=5;
    self.emailTxtFld.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    self.emailTxtFld.placeholder=@" Email";
    self.emailTxtFld.keyboardType=UIKeyboardTypeEmailAddress;
    self.emailTxtFld.leftViewMode = UITextFieldViewModeAlways;
    self.emailTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [self.signUpView addSubview:self.emailTxtFld];
    
    
       
    //Password text Field
    
    self.passwordTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10,self.emailTxtFld.frame.origin.y+self.emailTxtFld.frame.size.height+10, self.signUpView.frame.size.width-20, textFieldWidth)];
    self.passwordTxtFld.layer.cornerRadius=5;
     self.passwordTxtFld.delegate=self;
    self.passwordTxtFld.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    self.passwordTxtFld.placeholder=@" Password";
    self.passwordTxtFld.secureTextEntry=YES;
    self.passwordTxtFld.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [self.signUpView addSubview:self.passwordTxtFld];
    
    
    //Conform Password text Field
    
    self.reEnterPasswordTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10,self.passwordTxtFld.frame.origin.y+self.passwordTxtFld.frame.size.height+10, self.signUpView.frame.size.width-20, textFieldWidth)];
    self.reEnterPasswordTxtFld.layer.cornerRadius=5;
    self.reEnterPasswordTxtFld.delegate=self;
    self.reEnterPasswordTxtFld.secureTextEntry=YES;
    self.reEnterPasswordTxtFld.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    self.reEnterPasswordTxtFld.placeholder=@" Re Enter Password";
    self.reEnterPasswordTxtFld.leftViewMode = UITextFieldViewModeAlways;
    self.reEnterPasswordTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [self.signUpView addSubview:self.reEnterPasswordTxtFld];

    
    //sign Up button
    
    self.signUpButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self. signUpButton.frame=CGRectMake(10, self.reEnterPasswordTxtFld.frame.origin.y+self.reEnterPasswordTxtFld.frame.size.height+10, self.signUpView.frame.size.width-20, textFieldWidth);
    [self.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignUpBtn_inactive"] forState:UIControlStateNormal];
     [self.signUpButton addTarget:self action:@selector(signUpAction) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpView addSubview:self.signUpButton];
    
    

//
//    //Facebook Login button
//    
//    self.facebookSignUpBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    self.facebookSignUpBtn.frame=CGRectMake(10, self.signUpView.frame.size.height-60, self.signUpView.frame.size.width-20, textFieldWidth);
//    [self.facebookSignUpBtn setBackgroundImage:[UIImage imageNamed:@"FacebookSignUp_btn"] forState:UIControlStateNormal];
//    
//   
//    [self.facebookSignUpBtn addTarget:self action:@selector(facebookLoginAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.signUpView addSubview:    self.facebookSignUpBtn];
    
    
    //Separator Or Image
//    
//    UIImageView *separatorImgView=[[UIImageView alloc]init];
//    
//    
//    float dist=(self.facebookSignUpBtn.frame.origin.y-(self.signUpButton.frame.origin.y+self.signUpButton.frame.size.height))/2+(self.signUpButton.frame.origin.y+self.signUpButton.frame.size.height);
//    
//    
//    if(screenRect.size.width>=375&&screenRect.size.height>=667)
//        separatorImgView.frame=CGRectMake(screenRect.size.width/2-10,dist-25, 30, 30);
//    
//    else
//        
//        separatorImgView.frame=CGRectMake(screenRect.size.width/2-10,dist-15, 40, 40);
//    
//    
//    separatorImgView.image=[UIImage imageNamed:@"orSeparator"];
//    [self.signUpView addSubview:separatorImgView];
    

    
    float sizeOfContent = 0;
    UIView *lLast = [_scrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=20;
    sizeOfContent = wd+ht;
    _scrollView.contentSize=CGSizeMake(screenRect.size.width,sizeOfContent+offset);
    
    [self registerForKeyboardNotifications];
    

    
}



#pragma mark- Text field delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

#pragma mark- text Field Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    currentTextField=textField;
}


#pragma mark- login View
-(void)createLoginView{
    
  
    //Scroll View
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _headerView.frame.origin.y+_headerView.frame.size.height, screenRect.size.width, screenRect.size.height-(_headerView.frame.origin.y+_headerView.frame.size.height))];
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    


    
    //Login View
    self.loginView=[[UIView alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width, screenRect.size.height-self.headerView.frame.size.height)];
    [self.loginView setBackgroundColor:[UIColor clearColor]];
    [_scrollView addSubview:self.loginView];
    
    
    //Down Arrow Image
    
    UIImageView *downArrow=[[UIImageView alloc]init];
    
    if(screenRect.size.width<=320)
    downArrow.frame=CGRectMake(self.loginView.frame.size.width-80, -1, 17, 17);
    else
    downArrow.frame=CGRectMake(self.loginView.frame.size.width-90, -1, 17, 17);
    downArrow.image=[UIImage imageNamed:@"downarrow"];
   // [self.loginView addSubview:downArrow];

    
    
    
   
    //User name Text Field
    
   self.userNameTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10,20, self.loginView.frame.size.width-20, textFieldWidth)];
    self.userNameTxtFld.delegate=self;
    self.userNameTxtFld.layer.cornerRadius=5;
    self.userNameTxtFld.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    self.userNameTxtFld.placeholder=@" User Name or Email";
    NSString* fontName = FONT_NAME;
    self.userNameTxtFld.font  =  [UIFont fontWithName:fontName size:14];
    self.userNameTxtFld.text=@"";
    self.userNameTxtFld.leftViewMode = UITextFieldViewModeAlways;
    self.userNameTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    
    [self.loginView addSubview:self.userNameTxtFld];
    
    
    //Password Text Field
    
    self.passwordTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10,self.userNameTxtFld.frame.origin.y+self.userNameTxtFld.frame.size.height+20, self.loginView.frame.size.width-20, textFieldWidth)];
    self.passwordTxtFld.delegate=self;
    self.passwordTxtFld.layer.cornerRadius=5;
    self.passwordTxtFld.font  =  [UIFont fontWithName:fontName size:14];
    self.passwordTxtFld.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    self. passwordTxtFld.placeholder=@" Password";
    self.passwordTxtFld.text=@"";
    self.passwordTxtFld.secureTextEntry=YES;
    self.passwordTxtFld.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    
    [self.loginView addSubview:self.passwordTxtFld];
    

    //Login button
    
        self.loginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        self. loginButton.frame=CGRectMake(10, self.passwordTxtFld.frame.origin.y+self.passwordTxtFld.frame.size.height+30, self.loginView.frame.size.width-20, textFieldWidth);
        [self.loginButton setBackgroundImage:[UIImage imageNamed:@"LoginButton_inactive"] forState:UIControlStateNormal];
        [self.loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [self.loginView addSubview:self.loginButton];
    
    
    
       
    
    
//    //Facebook Login button
//    
//    self.facebookLoginBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//        self.facebookLoginBtn.frame=CGRectMake(10, self.loginView.frame.size.height-60, self.loginView.frame.size.width-20, textFieldWidth);
//    [self.facebookLoginBtn setBackgroundImage:[UIImage imageNamed:@"facebookBtn"] forState:UIControlStateNormal];
//    [self.facebookLoginBtn addTarget:self action:@selector(facebookLoginAction) forControlEvents:UIControlEventTouchUpInside];
//  //  [self.loginView addSubview:    self.facebookLoginBtn];
//    
//
//    //Separator Or Image
//    
//    UIImageView *separatorImgView=[[UIImageView alloc]init];
//    
//    
//    float dist=(self.facebookLoginBtn.frame.origin.y-(self.loginButton.frame.origin.y+self.loginButton.frame.size.height))/2+(self.loginButton.frame.origin.y+self.loginButton.frame.size.height);
//    
//
//    if(screenRect.size.width>=375&&screenRect.size.height>=667)
//                                   separatorImgView.frame=CGRectMake(screenRect.size.width/2-10,dist-30, 40, 40);
//    
//    else
//        
//          separatorImgView.frame=CGRectMake(screenRect.size.width/2-10,dist-15, 40, 40);
//        
//                                  
//    separatorImgView.image=[UIImage imageNamed:@"orSeparator"];
//   // [self.loginView addSubview:separatorImgView];
//    
    
    
    float sizeOfContent = 0;
    UIView *lLast = [_scrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=20;
    sizeOfContent = wd+ht;
    _scrollView.contentSize=CGSizeMake(screenRect.size.width,sizeOfContent+offset);
    
    [self registerForKeyboardNotifications];
    
    


    
}


#pragma mark- Login Action
-(void)loginAction{
    if([_userNameTxtFld.text isEqual:@""]){
        [self.view makeToast:@"User name missing!"];
           }else if([_passwordTxtFld.text isEqual:@"" ]){
               [self.view makeToast:@"Password missing!"];

               
           }else{
    
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"LoginButton_active"] forState:UIControlStateNormal];
    
               [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
   
       [APIHelperClass loginService:self.userNameTxtFld.text password:self.passwordTxtFld.text success:^(NSDictionary * loginResponseMsg){
           
           
           
           serviceResponse=[loginResponseMsg objectForKey:@"message"];
           responseCode=[[loginResponseMsg objectForKey:@"code"]intValue];
    
           
           [[NSUserDefaults standardUserDefaults] setObject:[[loginResponseMsg objectForKey:@"data"] objectForKey:@"id"] forKey:@"user_ID"];
           [[NSUserDefaults standardUserDefaults] setObject:[[loginResponseMsg objectForKey:@"data"] objectForKey:@"role"] forKey:@"user_Role"];
           [[NSUserDefaults standardUserDefaults]synchronize];

          
           dispatch_semaphore_signal(semaphore);
            
    }];
      
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
     dispatch_async(dispatch_get_main_queue(), ^{
         
         [SVProgressHUD dismiss];
                      // [self.navigationController pushViewController:rootVc animated:YES];
          
         if(serviceResponse == nil)
             [self.view makeToast:@"Something Went Wrong!!"];
         
         

             [self.view makeToast:serviceResponse];
         
         
         if(responseCode==200){
            
//            DashBoardVC * dashBoard = [[DashBoardVC alloc]init];
//            ProfileVC *profile = [[ProfileVC alloc]init];
//            ChangePasswordVC *changePasswordVC =[[ChangePasswordVC alloc]init];
//            RootViewController* root =[[RootViewController alloc]initWithViewControllers:@[dashBoard, profile, changePasswordVC] andMenuTitles:@[@"",@"",@""]];
//                    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:root];
//            
//            self.view.window.rootViewController = navi;
//            [self.navigationController pushViewController:root animated:YES];
           //  [self.view.window makeKeyAndVisible];

             
             
             [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
             [[NSNotificationCenter defaultCenter]removeObserver:self name:@"loginSuccess" object:nil];
             
              [self.loginButton setBackgroundImage:[UIImage imageNamed:@"LoginButton_inactive"] forState:UIControlStateNormal];
         }else{
             [self.loginButton setBackgroundImage:[UIImage imageNamed:@"LoginButton_inactive"] forState:UIControlStateNormal];

         }
       
         
                });
      
});
 
  
           }
    
    
}
         



#pragma mark- Sign Up Action
-(void)signUpAction{
   

    if([_userNameTxtFld.text isEqual:@""])
        [self.view makeToast:@"User name missing!"];
    else if([_emailTxtFld.text isEqual:@"" ])
        [self.view makeToast:@"Email missing!"];
    else if ([_passwordTxtFld.text isEqual:@"" ])
        [self.view makeToast:@"Password missing!"];
    else if ([_reEnterPasswordTxtFld.text isEqual:@""])
        [self.view makeToast:@"Re Enter Password missing!"];
    else if(![_passwordTxtFld.text isEqual:_reEnterPasswordTxtFld.text]){
        [self.view makeToast:@"Re Enter Password must match!"];
        _passwordTxtFld.text=@"";
    }else{
        
        
        [self.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignUpBtn_active"] forState:UIControlStateNormal];
        [SVProgressHUD show];
          dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
          
            
            [APIHelperClass signUpService:_emailTxtFld.text password:_passwordTxtFld.text name:_userNameTxtFld.text  success:^(NSDictionary * loginResponseMsg){
                
                
                
                serviceResponse=[loginResponseMsg objectForKey:@"message"];
                responseCode=[[loginResponseMsg objectForKey:@"code"]intValue];
                
                
                
                dispatch_semaphore_signal(semaphore);
                
            }];
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                // [self.navigationController pushViewController:rootVc animated:YES];
                
                if(serviceResponse == nil)
                    [self.view makeToast:@"Something Went Wrong!!"];
                
                

                [self.view makeToast:serviceResponse];
                
                
                if(responseCode==200){
                    
                _userNameTxtFld.text=@"";
                _passwordTxtFld.text=@"";
                _reEnterPasswordTxtFld.text=@"";
                _emailTxtFld.text=@"";
                    
                    
                     [self.loginButton setBackgroundImage:[UIImage imageNamed:@"SignUpBtn_inactive"] forState:UIControlStateNormal];
//                    [NSUserDefaults standardUserDefaults]setObject:<#(nullable id)#> forKey:<#(nonnull NSString *)#>
                    
                    
                }else{
                    
                    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"SignUpBtn_inactive"] forState:UIControlStateNormal];
                    
                }
                
                
            });
            
        });
        
        

        
        
    }
    
        
    
    
    
}

#pragma mark- Login Menu Btn Action
-(void)loginMenuBtnActn{
    
    
    if(loginClicked==NO){
        
        loginClicked=YES;
    
    [self.signUpView removeFromSuperview];
    
    [self createLoginView];
    
  
    
    NSLog(@"Login menu btn");
    }
    
}

#pragma mark- SignUp Menu Btn Action
-(void)signUpMenuBtnActn{
    
   
    
    if(loginClicked==YES){
        
        loginClicked=NO;
    
    [self.loginView removeFromSuperview];
    
    [self createSignUpView];
    
    NSLog(@"SignUp menu btn");
    }


    
}

#pragma mark- Facebook Login Action
-(void)facebookLoginAction{
    
//    if ([FBSDKAccessToken currentAccessToken]) {
//        
//        NSLog(@"Login Access Token : %@",[FBSDKAccessToken currentAccessToken].tokenString);
//        
//        
//        [self.view makeToast:@"You are already logged in with facebook"];
//        ;
//        // TODO:Token is already available.
//    }else{
//    
//    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//    [login
//     logInWithReadPermissions: @[@"public_profile",@"email"]
//     fromViewController:self
//     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//         if (error) {
//             NSLog(@"Process error");
//         } else if (result.isCancelled) {
//             NSLog(@"Cancelled");
//         } else {
//        
//             
//             
//             
//             [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, email"}]
//              startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//                  
//            
//                  if(!error){
//                      NSLog(@"Result :%@",result);
//                      
//                      [self.view makeToast:@"Logged in with facebook"];
//                  }
//                  
//                  
//              }];
//             
//             
//             
//             
//             
//            
//             
//         }
//     }];
   // }
}



#pragma mark- Facebook Sign Up Action
-(void)facebookSignUpAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


//-(void)fbLoginAction
//{
//    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//   
//    [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
//     {
//         if (error)
//         {
//             // Process error
//         }
//         else if (result.isCancelled)
//         {
//             // Handle cancellations
//         }
//         else
//         {
//             if ([result.grantedPermissions containsObject:@"email"])
//             {
//                 NSLog(@"result is:%@",result);
//                 [self fetchUserInfo];
//             }
//         }
//     }];
//}
//
//-(void)fetchUserInfo
//{
//    if ([FBSDKAccessToken currentAccessToken])
//    {
//        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
//        
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error)
//             {
//                 
//                 
//                 
//             }
//         }
//         else
//         {
//             NSLog(@"Error %@",error);
//         }
//         }];
//        
//    }
//    
//}

@end

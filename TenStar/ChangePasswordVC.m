//
//  ChangePasswordVC.m
//  TenStar
//
//  Created by Dharasis on 21/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "APIHelperClass.h"
@interface ChangePasswordVC ()
{
    float textFieldWidth;
    UITextField* currentTextField;
    NSString* serviceResponse;
    int responseCode;
}
@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    
    if(screenRect.size.height<=568){
        textFieldWidth=40;
    }else{
        textFieldWidth=50;
    }
    
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, screenRect.size.width, 155)];
    headView.userInteractionEnabled=YES;
    headView.image = [UIImage imageNamed:@"updatePasswordHeadView"];
    [self.view addSubview:headView];
    
    
    
    
    //Adding Menu Option
    
    UIButton *menuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"MenuBtn"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(20,10,30,30);
    [ menuBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:menuBtn];
    
    
    //Scroll View
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headView.frame.origin.y+headView.frame.size.height, screenRect.size.width, screenRect.size.height-(headView.frame.origin.y+headView.frame.size.height))];
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    
    
    //Old Password Text Field
    
    self.oldPasswordTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10,20, self.scrollView.frame.size.width-20, textFieldWidth)];
    self.oldPasswordTxtFld.layer.cornerRadius=5;
    self.oldPasswordTxtFld.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    self.oldPasswordTxtFld.secureTextEntry=YES;
    self.oldPasswordTxtFld.delegate=self;
    self.oldPasswordTxtFld.font=[UIFont systemFontOfSize:12];
    self.oldPasswordTxtFld.placeholder=@" Enter Old Password";
    self.oldPasswordTxtFld.leftViewMode = UITextFieldViewModeAlways;
    self.oldPasswordTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [self.scrollView addSubview:self.oldPasswordTxtFld];
    
    
    //New Password Text Field
    
    self.passwordTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10,self.oldPasswordTxtFld.frame.origin.y+self.oldPasswordTxtFld.frame.size.height+20, self.scrollView.frame.size.width-20, textFieldWidth)];
    self.passwordTxtFld.layer.cornerRadius=5;
      self.passwordTxtFld.font=[UIFont systemFontOfSize:12];
        self.passwordTxtFld.delegate=self;
    self.passwordTxtFld.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    self.passwordTxtFld.secureTextEntry=YES;
    self.passwordTxtFld.placeholder=@" Enter New Password";
    self.passwordTxtFld.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [self.scrollView addSubview:self.passwordTxtFld];
    

    //New Password Again Text Field
    
    self.agnPasswordTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(10,self.passwordTxtFld.frame.origin.y+self.passwordTxtFld.frame.size.height+20, self.scrollView.frame.size.width-20, textFieldWidth)];
    self.agnPasswordTxtFld.layer.cornerRadius=5;
      self.agnPasswordTxtFld.font=[UIFont systemFontOfSize:12];
    self.agnPasswordTxtFld.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    self.agnPasswordTxtFld.delegate=self;
       self.agnPasswordTxtFld.secureTextEntry=YES;
    self.agnPasswordTxtFld.placeholder=@" Re Enter New Password";
    self.agnPasswordTxtFld.leftViewMode = UITextFieldViewModeAlways;
    self.agnPasswordTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    [self.scrollView addSubview:self.agnPasswordTxtFld];
    

    //Update password button
    
    self.updatePasswordBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self. updatePasswordBtn.frame=CGRectMake(10, self.agnPasswordTxtFld.frame.origin.y+self.agnPasswordTxtFld.frame.size.height+20, screenRect.size.width-20, textFieldWidth);
    [self.updatePasswordBtn setBackgroundImage:[UIImage imageNamed:@"updatePassword_normalBtn"] forState:UIControlStateNormal];
    [self.updatePasswordBtn addTarget:self action:@selector(updatePasswordActn) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.updatePasswordBtn];
 
    
    float sizeOfContent = 0;
    UIView *lLast = [_scrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=20;
    sizeOfContent = wd+ht;
    _scrollView.contentSize=CGSizeMake(screenRect.size.width,sizeOfContent+offset);
    
    [self registerForKeyboardNotifications];
    
    
    // Do any additional setup after loading the view.
}


#pragma mark- Update Password Button
-(void)updatePasswordActn{
    
    if([_oldPasswordTxtFld.text isEqual:@""])
        [self.view makeToast:@"Old Password Missing!"];
    else if ([_passwordTxtFld.text isEqual:@""])
        [self.view makeToast:@"New Password Missing!"];
    else if ([_agnPasswordTxtFld.text isEqual:@""])
        [self.view makeToast:@"Re Enter Password Missing!"];
    else if(![_passwordTxtFld.text isEqual:_agnPasswordTxtFld.text]){
        [self.view makeToast:@"Re Enter Password must match!"];
    }else{
        [self.updatePasswordBtn setBackgroundImage:[UIImage imageNamed:@"updatePass_SelectedBtn"] forState:UIControlStateNormal];

        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [SVProgressHUD show];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_ID"];
            
            [APIHelperClass updatePasswordService:userId newPassword:_passwordTxtFld.text oldPassword:_oldPasswordTxtFld.text success:^(NSDictionary* responseMsg)    {
                
                
                
                
                serviceResponse=[responseMsg objectForKey:@"message"];
                responseCode=[[responseMsg objectForKey:@"code"]intValue];
                
                
                
                dispatch_semaphore_signal(semaphore);
                
            }];
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // [self.navigationController pushViewController:rootVc animated:YES];
                
                [SVProgressHUD dismiss];
                
                if(serviceResponse == nil)
                    [self.view makeToast:@"Something Went Wrong!!"];

                
                [_scrollView makeToast:serviceResponse];
                
                
                if(responseCode==200){
                    _oldPasswordTxtFld.text=@"";
                    _passwordTxtFld.text=@"";
                    _agnPasswordTxtFld.text=@"";
                    
                }else{
                    [self.updatePasswordBtn setBackgroundImage:[UIImage imageNamed:@"updatePassword_normalBtn"] forState:UIControlStateNormal];

                    
                }
                
                
            });
            
        });
        
        
        
        
        
    }
    
    
    
}

-(void)backButtonAction{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"toggleMenuVisibility" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"toggleMenuVisibility" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    currentTextField=textField;
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

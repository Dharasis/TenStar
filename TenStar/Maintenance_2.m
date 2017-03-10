//
//  Maintenance_2.m
//  TenStar
//
//  Created by Dharasis on 06/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "Maintenance_2.h"

@interface Maintenance_2 ()
{
    UIImageView *headView;
    UITextField* dateTxtFld;
    float textFieldWidth;
    UIButton *dashBoardBtn;
    UITextField* currentTextField;
    UIScrollView *scrollView;
    NSString* serviceResponse;
    int serviceCode;
}

@end

@implementation Maintenance_2
-(id)init{
    if (self = [super init]){
        
    }
    
    return self;
}
-(id)init:(NSString*)doorName Doorid:(int)doorID{
    if (self = [super init]){
        
        _doorID = doorID;
        _doorName = doorName;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(screenRect.size.height<=568){
        textFieldWidth=40;
    }else{
        textFieldWidth=50;
    }
    

    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView*  _navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
    _navigationBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
    _navigationBar.userInteractionEnabled=YES;
    [self.view addSubview:_navigationBar];
    
    headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, screenRect.size.width, 155)];
    headView.userInteractionEnabled=YES;
    headView.image = [UIImage imageNamed:@"MaintenanceExHeader"];
    [self.view addSubview:headView];
    
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headView.frame.origin.y+headView.frame.size.height, screenRect.size.width, screenRect.size.height-(headView.frame.origin.y+headView.frame.size.height))];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    scrollView.scrollEnabled=YES;
    [self.view addSubview:scrollView];
    
    [self createUI];
    
    // Do any additional setup after loading the view.
    
    // Do any additional setup after loading the view.
}

-(void)createUI{
    
    NSString* fontName = FONT_NAME;

    UILabel *question = [[UILabel alloc]init];
    question.frame = CGRectMake(0, 10, screenRect.size.width, 30);
    question.textAlignment = NSTextAlignmentCenter;
    question.text = @"Enter the Date and Time";
    question.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1];
    question.font = [UIFont fontWithName:fontName size:16];
    [scrollView addSubview:question];
    

    //User name Text Field
    dateTxtFld=[[UITextField alloc]initWithFrame:CGRectMake(20,question.frame.origin.y+question.frame.size.height+10, screenRect.size.width-40, textFieldWidth)];
    dateTxtFld.delegate=self;
    dateTxtFld.layer.cornerRadius=5;
    dateTxtFld.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    dateTxtFld.placeholder=@"Select the date and time";
    dateTxtFld.font = [UIFont fontWithName:fontName size:16];
    dateTxtFld.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    dateTxtFld.leftViewMode = UITextFieldViewModeAlways;
    [scrollView addSubview:dateTxtFld];
    
    dashBoardBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dashBoardBtn.frame = CGRectMake(20,dateTxtFld.frame.origin.y+dateTxtFld.frame.size.height+20,screenRect.size.width-40,textFieldWidth);
    [dashBoardBtn setBackgroundImage:[UIImage imageNamed:@"ProceedDashboard"] forState:UIControlStateNormal];
    [dashBoardBtn addTarget:self action:@selector(dashboardAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:dashBoardBtn];
    float sizeOfContent = 0;
    UIView *lLast = [scrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=20;
    sizeOfContent = wd+ht;
    scrollView.contentSize=CGSizeMake(screenRect.size.width,sizeOfContent+offset);
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
    
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    
    NSLog(@"%@",[dateFormatter stringFromDate:now]);
    
    textField.text = [dateFormatter stringFromDate:now];
    textField.enabled = NO;
    
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
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your application might not need or want this behavior.
        CGRect aRect = self.view.frame;
        aRect.size.height -= kbSize.height;
        if (!CGRectContainsPoint(aRect, currentTextField.frame.origin) ) {
            CGPoint scrollPoint = CGPointMake(0.0, currentTextField.frame.origin.y-kbSize.height);
            [scrollView setContentOffset:scrollPoint animated:YES];
        }
    }
    
    
    // Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
    {
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
    }
    

    


-(void)dashboardAction{
    
    
    if([dateTxtFld.text isEqual:@""]){
        [self.view makeToast:@"Date and Time Missing!!"];

        
    }
    else{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [SVProgressHUD show];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [APIHelperClass doorMaintenanceNotPermited:[[NSUserDefaults standardUserDefaults] objectForKey:@"FrontDoor"] permited:[[NSUserDefaults standardUserDefaults] objectForKey:@"Permitted"]  permitedDate:dateTxtFld.text doorId:[NSString stringWithFormat:@"%d",_doorID] :^(NSDictionary* responseMsg)    {
            
            
            //
            //            profileDict = responseMsg;
            serviceResponse=[responseMsg objectForKey:@"message"];
            serviceCode=[[responseMsg objectForKey:@"code"]intValue];
            //
            
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            if(serviceResponse == nil)
                [self.view makeToast:@"Something Went Wrong!!"];
            
            
            [self.view makeToast:serviceResponse];
            
            //    [self createUI];
            
            
            
            
            if(serviceCode==200){
                
                
                [dashBoardBtn setBackgroundImage:[UIImage imageNamed:@"ProceedDashboard_select"] forState:UIControlStateNormal];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        
        
        
   
        });
    });
}


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

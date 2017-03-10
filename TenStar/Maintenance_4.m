//
//  Maintenance_4.m
//  TenStar
//
//  Created by Dharasis on 06/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "Maintenance_4.h"

@interface Maintenance_4 ()
{
    UIImageView *headView;
    UIButton * radioBtnYes,*radioBtnNo;
    BOOL yes;
    UITextField* currentTextField;
    UIScrollView *scrollView;
    UITextField* tubeQuantity;
    float textFieldWidth;

    
}


@end

@implementation Maintenance_4

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
    scrollView.userInteractionEnabled = YES;
    [self.view addSubview:scrollView];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
       [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self createUI];
    
    // Do any additional setup after loading the view.
}


-(void)createUI{
    
     NSString* fontName = FONT_NAME;
    UIImageView * footerView = [[UIImageView alloc]init];
    footerView.frame = CGRectMake(0, screenRect.size.height-150, screenRect.size.width, 150);
    footerView.userInteractionEnabled = YES;
    
    footerView.image = [UIImage imageNamed:@"MaintainanceFooter"];
    [self.view addSubview:footerView];
    
    
    UILabel *doorId_label = [[UILabel alloc]init];
    doorId_label.frame = CGRectMake(0, 10,screenRect.size.width, 20);
    doorId_label.text = [NSString stringWithFormat:@"Door ID - %d",_doorID];
    doorId_label.font=[UIFont fontWithName:fontName size:15];
    doorId_label.textAlignment = NSTextAlignmentCenter;
    doorId_label.textColor = [UIColor whiteColor];
    [footerView addSubview:doorId_label];
    
    
    UILabel *doorName_label = [[UILabel alloc]init];
    doorName_label.frame = CGRectMake(0, doorId_label.frame.origin.y+doorId_label.frame.size.height+10,screenRect.size.width, 20);
    doorName_label.text = [NSString stringWithFormat:@"Door Name - %@",_doorName];
    doorName_label.textAlignment = NSTextAlignmentCenter;
    doorName_label.font=[UIFont fontWithName:fontName size:15];
    doorName_label.textColor = [UIColor whiteColor];
    [footerView addSubview:doorName_label];
    
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(20, footerView.frame.size.height-70, 100, 50);
    [backButton setBackgroundImage:[UIImage imageNamed:@"SelectDoorBackBtn"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:backButton];
    
    
    
    UIButton * nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextButton.frame = CGRectMake(footerView.frame.size.width-130, footerView.frame.size.height-70, 120, 50);
    [nextButton setBackgroundImage:[UIImage imageNamed:@"selectDoorContinue"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:nextButton];
    
    
    
    UILabel *question = [[UILabel alloc]init];
    question.frame = CGRectMake(0, 10, screenRect.size.width, 30);
    question.textAlignment = NSTextAlignmentCenter;
    question.text = @"Is Tube change required ?";
    question.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;question.font = [UIFont fontWithName:fontName size:16];
    [scrollView addSubview:question];
    
    
    
    radioBtnYes = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radioBtnYes.frame = CGRectMake(50,question.frame.origin.y+question.frame.size.height+20,20,20);
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    [radioBtnYes addTarget:self action:@selector(radioBtnYesAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:radioBtnYes];
    
    
    UILabel *permittedLbl = [[UILabel alloc]init];
    permittedLbl.frame = CGRectMake(radioBtnYes.frame.origin.x+radioBtnYes.frame.size.width+5,question.frame.origin.y+question.frame.size.height+10, 80, 40);
    permittedLbl.text=@"Yes";
    permittedLbl.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;permittedLbl.font = [UIFont fontWithName:fontName size:16];
    [scrollView addSubview:permittedLbl];
    
    
    radioBtnNo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radioBtnNo.frame = CGRectMake(scrollView.frame.size.width/2+10,question.frame.origin.y+question.frame.size.height+20,20,20);
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [radioBtnNo addTarget:self action:@selector(radioBtnNoAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:radioBtnNo];
    
    
    yes = NO;
    
    
    
    UILabel *notPermittedLbl = [[UILabel alloc]init];
    notPermittedLbl.frame = CGRectMake(radioBtnNo.frame.origin.x+radioBtnNo.frame.size.width+5,question.frame.origin.y+question.frame.size.height+10, 100, 40);
    notPermittedLbl.text=@"No";
    notPermittedLbl.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;notPermittedLbl.font = [UIFont fontWithName:fontName size:16];
    [scrollView addSubview:notPermittedLbl];
    
    
    
    tubeQuantity=[[UITextField alloc]initWithFrame:CGRectMake(20,radioBtnNo.frame.origin.y+radioBtnNo.frame.size.height+30, screenRect.size.width-40, textFieldWidth)];
    tubeQuantity.delegate=self;
    tubeQuantity.layer.cornerRadius=5;
    tubeQuantity.hidden= YES;
    tubeQuantity.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
    tubeQuantity.placeholder=@"Enter tude Quantity";
    tubeQuantity.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfieldBorder"]];
    tubeQuantity.font = [UIFont fontWithName:fontName size:16];
    tubeQuantity.keyboardType=UIKeyboardTypeNumberPad;
    tubeQuantity.leftViewMode = UITextFieldViewModeAlways;
    [scrollView addSubview:tubeQuantity];

    float sizeOfContent = 0;
    UIView *lLast = [scrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=20;
    sizeOfContent = wd+ht;
    scrollView.contentSize=CGSizeMake(screenRect.size.width,sizeOfContent+offset);
    [self registerForKeyboardNotifications];

    
    
}

- (void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer{
    [tubeQuantity resignFirstResponder];// This will dismiss your keyBoard.
}

#pragma mark- text Field Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    currentTextField=textField;
    
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




#pragma mark- Text field delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

-(void)radioBtnYesAction{
    
    yes = YES;
    
    tubeQuantity.hidden=NO;
    
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    
}


-(void)radioBtnNoAction{
    
    yes = NO;
      tubeQuantity.hidden=YES;
    
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)nextAction{
    NSString* tube;
    
    if(yes)
    {   tube = @"1";

        
    }else{
        
        tube = @"0";

        
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:tube forKey:@"tubeChange"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    if(yes){
        
        
              if([tubeQuantity.text isEqual:@""])
            [self.view makeToast:@"Tube Quantity Missing!"];
        else{
            
            
            [[NSUserDefaults standardUserDefaults]setObject:tubeQuantity.text forKey:@"tubeQuantity"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            Maintenance_5 * maintenance_5 = [[Maintenance_5 alloc]init:_doorName Doorid:_doorID];
            [self.navigationController pushViewController:maintenance_5 animated:YES];

        }
        
    }
    
    else{
        
              
        
        Maintenance_5 * maintenance_5 = [[Maintenance_5 alloc]init:_doorName Doorid:_doorID];
        [self.navigationController pushViewController:maintenance_5 animated:YES];

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

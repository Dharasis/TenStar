//
//  Maintenance_9.m
//  TenStar
//
//  Created by Dharasis on 06/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "Maintenance_9.h"

@interface Maintenance_9 ()
{
    UIImageView *headView;
    UIButton * radioBtnYes,*radioBtnNo;
    BOOL yes;
}
@end

@implementation Maintenance_9

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
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView*  _navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
    _navigationBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
    _navigationBar.userInteractionEnabled=YES;
    [self.view addSubview:_navigationBar];
    
    headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, screenRect.size.width, 155)];
    headView.userInteractionEnabled=YES;
    headView.image = [UIImage imageNamed:@"MaintenanceExHeader"];
    [self.view addSubview:headView];
    
    
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
    question.frame = CGRectMake(0, headView.frame.origin.y+headView.frame.size.height+10, screenRect.size.width, 30);
    question.textAlignment = NSTextAlignmentCenter;
    question.text = @"Is there any planogram issue ?";
    question.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;question.font = [UIFont fontWithName:fontName size:16];
    [self.view addSubview:question];
    
    
    
    radioBtnYes = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radioBtnYes.frame = CGRectMake(50,question.frame.origin.y+question.frame.size.height+20,20,20);
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    [radioBtnYes addTarget:self action:@selector(radioBtnYesAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:radioBtnYes];
    
    
    UILabel *permittedLbl = [[UILabel alloc]init];
    permittedLbl.frame = CGRectMake(radioBtnYes.frame.origin.x+radioBtnYes.frame.size.width+5,question.frame.origin.y+question.frame.size.height+10, 80, 40);
    permittedLbl.text=@"Yes";
    permittedLbl.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;permittedLbl.font = [UIFont fontWithName:fontName size:16];
    [self.view addSubview:permittedLbl];
    
    
    radioBtnNo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radioBtnNo.frame = CGRectMake(screenRect.size.width/2+10,question.frame.origin.y+question.frame.size.height+20,20,20);
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [radioBtnNo addTarget:self action:@selector(radioBtnNoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:radioBtnNo];
    
    
    UILabel *notPermittedLbl = [[UILabel alloc]init];
    notPermittedLbl.frame = CGRectMake(radioBtnNo.frame.origin.x+radioBtnNo.frame.size.width+5,question.frame.origin.y+question.frame.size.height+10, 100, 40);
    notPermittedLbl.text=@"No";
    notPermittedLbl.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;notPermittedLbl.font = [UIFont fontWithName:fontName size:16];
    [self.view addSubview:notPermittedLbl];
    
    yes = NO;
    
    
    
}



-(void)radioBtnYesAction{
    
    yes = YES;
    
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    
}


-(void)radioBtnNoAction{
    
    
    yes  =  NO;
    
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)nextAction{

    
    NSString* plsnogramIssue;
    
    if(yes){
        plsnogramIssue = @"1";
    }else{
        plsnogramIssue = @"0";
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:plsnogramIssue forKey:@"planogramIssue"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if(yes){
        Maintenance_9s * maintenance_9s = [[Maintenance_9s alloc]init:_doorName Doorid:_doorID];
        [self.navigationController pushViewController:maintenance_9s animated:YES];

    }else{
     
        Maintenance_10 * maintenance_10 = [[Maintenance_10 alloc]init:_doorName Doorid:_doorID];
        [self.navigationController pushViewController:maintenance_10 animated:YES];
        
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

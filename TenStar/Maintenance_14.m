//
//  Maintenance_14.m
//  TenStar
//
//  Created by Dharasis on 06/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "Maintenance_14.h"

@interface Maintenance_14 (){
    
    UIImageView *headView;
    UIScrollView *scrollView;
    UIButton * radioBtnYes,*radioBtnNo,*agreeBtn,*dashBoardBtn;
    int doorStatus;
    NSString* serviceResponse;
    int serviceCode;
}

@end

@implementation Maintenance_14
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
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView*  _navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
    _navigationBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
    _navigationBar.userInteractionEnabled=YES;
    [self.view addSubview:_navigationBar];
    
    headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, screenRect.size.width, 155)];
    headView.userInteractionEnabled=YES;
    headView.image = [UIImage imageNamed:@"MaintenanceExHeader"];
    [self.view addSubview:headView];
    
    
    //Scroll View
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headView.frame.origin.y+headView.frame.size.height, screenRect.size.width, screenRect.size.height-(headView.frame.origin.y+headView.frame.size.height))];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    scrollView.scrollEnabled=YES;
    [self.view addSubview:scrollView];
    

    [self createUI];
    // Do any additional setup after loading the view.
}

#pragma mark- create UI
-(void)createUI{
  
    NSString* fontName = FONT_NAME;

    UILabel *doorId_label = [[UILabel alloc]init];
    doorId_label.frame = CGRectMake(10, 10,screenRect.size.width, 20);
    doorId_label.text = [NSString stringWithFormat:@"Door ID   - %d",_doorID];
    doorId_label.textAlignment = NSTextAlignmentLeft;
    doorId_label.font = [UIFont fontWithName:fontName size:14];
    doorId_label.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1];
    [scrollView addSubview:doorId_label];

    
    
    UILabel *doorName_label = [[UILabel alloc]init];
    doorName_label.frame = CGRectMake(10, doorId_label.frame.origin.y+doorId_label.frame.size.height+20,screenRect.size.width, 20);
    doorName_label.text = [NSString stringWithFormat:@"Door Name  - %@",_doorName];
    doorName_label.textAlignment = NSTextAlignmentLeft;
    doorName_label.font = [UIFont fontWithName:fontName size:14];
    doorName_label.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1];
    [scrollView addSubview:doorName_label];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, doorName_label.frame.origin.y+doorName_label.frame.size.height+30,screenRect.size.width, 20);
    label.text = @"Update the Door Status";
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1];
    label.font = [UIFont fontWithName:fontName size:14];
    [scrollView addSubview:label];

    
    radioBtnYes = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radioBtnYes.frame = CGRectMake(50,label.frame.origin.y+label.frame.size.height+20,20,20);
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    [radioBtnYes addTarget:self action:@selector(radioBtnYesAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:radioBtnYes];
    
    
    UILabel *permittedLbl = [[UILabel alloc]init];
    permittedLbl.frame = CGRectMake(radioBtnYes.frame.origin.x+radioBtnYes.frame.size.width+5,label.frame.origin.y+label.frame.size.height+10, 80, 40);
    permittedLbl.text=@"Maintenance";
    permittedLbl.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;permittedLbl.font = [UIFont fontWithName:fontName size:14];
    [scrollView addSubview:permittedLbl];
    
    
    
    radioBtnNo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radioBtnNo.frame = CGRectMake(screenRect.size.width/2+10,label.frame.origin.y+label.frame.size.height+20,20,20);
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [radioBtnNo addTarget:self action:@selector(radioBtnNoAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:radioBtnNo];
    
    
    UILabel *notPermittedLbl = [[UILabel alloc]init];
    notPermittedLbl.frame = CGRectMake(radioBtnNo.frame.origin.x+radioBtnNo.frame.size.width+5,label.frame.origin.y+label.frame.size.height+10, 100, 40);
    notPermittedLbl.text=@"Completed";
    notPermittedLbl.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;notPermittedLbl.font = [UIFont fontWithName:fontName size:14];
    [scrollView addSubview:notPermittedLbl];
    

    agreeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    agreeBtn.frame = CGRectMake(10,radioBtnNo.frame.origin.y+radioBtnNo.frame.size.height+20,20,20);
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [scrollView addSubview:agreeBtn];

    
    UILabel *agreeLbl = [[UILabel alloc]init];
    agreeLbl.frame = CGRectMake(agreeBtn.frame.origin.x+agreeBtn.frame.size.width+5,radioBtnNo.frame.origin.y+radioBtnNo.frame.size.height+10, 150, 40);
    agreeLbl.text=@"Agree to Disclaimer";
    agreeLbl.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;agreeLbl.font = [UIFont fontWithName:fontName size:14];
    [scrollView addSubview:agreeLbl];
    dashBoardBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dashBoardBtn.frame = CGRectMake(20,agreeLbl.frame.origin.y+agreeLbl.frame.size.height+20,scrollView.frame.size.width-40,50);
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


    doorStatus = 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)radioBtnYesAction{
    
    doorStatus = 0;
    
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    
}


-(void)radioBtnNoAction{
    
    doorStatus = 1;
    
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    
}
-(void)dashboardAction{
    NSString * doorStatusStr;
    
    if(doorStatus==1)
        doorStatusStr = @"1";
    else
        doorStatusStr = @"0";
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_ID"];
        
        NSDate *now = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        
        
      NSString* dateFinish =  [dateFormatter stringFromDate:now];
        
        [APIHelperClass maintenance:[[NSUserDefaults standardUserDefaults] objectForKey:@"FrontDoor"] permitted:[[NSUserDefaults standardUserDefaults] objectForKey:@"Permitted"]  door_id:[NSString stringWithFormat:@"%d",_doorID] pictures_of_wall:[[NSUserDefaults standardUserDefaults] objectForKey:@"WallUnitPic"] old_transformer_picture:[[NSUserDefaults standardUserDefaults] objectForKey:@"OldTransformerPhoto"]  picture_of_new_wire:[[NSUserDefaults standardUserDefaults] objectForKey:@"NewWirePhoto"]   planogram_picture:[[NSUserDefaults standardUserDefaults] objectForKey:@"PlanogramPhoto"] boutique_acrylic_repair_picture:[[NSUserDefaults standardUserDefaults] objectForKey:@"BountiqueAcylicRepairPhoto"] header_acrylic_picture:[[NSUserDefaults standardUserDefaults] objectForKey:@"HeaderAcylicPhoto"] door_complete_final_picture:[[NSUserDefaults standardUserDefaults] objectForKey:@"FinalDoor"]  tube_changed:[[NSUserDefaults standardUserDefaults] objectForKey:@"tubeChange"] tube_quantity:[[NSUserDefaults standardUserDefaults] objectForKey:@"tubeQuantity"]
                transformer_changed:[[NSUserDefaults standardUserDefaults] objectForKey:@"transformerChnged"] cable_service_required:[[NSUserDefaults standardUserDefaults] objectForKey:@"cableService"] visual_boutique_replaced:[[NSUserDefaults standardUserDefaults] objectForKey:@"visualBountique"]  boutique_quantity:[[NSUserDefaults standardUserDefaults] objectForKey:@"Hotspot"] paint_touch_up:[[NSUserDefaults standardUserDefaults] objectForKey:@"paintTouchUp"]  planogram_issue:[[NSUserDefaults standardUserDefaults] objectForKey:@"planogramIssue"] boutique_acrylic_repair:[[NSUserDefaults standardUserDefaults] objectForKey:@"BountiqueAcylicRepair"]  boutique_acrylic_description:[[NSUserDefaults standardUserDefaults] objectForKey:@"TubeHolder"]boutique_acrylic_replace: [[NSUserDefaults standardUserDefaults] objectForKey:@"BountiqueReplaced"] header_acrylic_replace:[[NSUserDefaults standardUserDefaults] objectForKey:@"HeaderAcylic"] drawer_rails_replaced:[[NSUserDefaults standardUserDefaults] objectForKey:@"DrawerRail"] drawer_rails_quantity:[[NSUserDefaults standardUserDefaults] objectForKey:@"drawerRailQuantity"]  door_status:doorStatusStr date_of_finished:dateFinish:^(NSDictionary* responseMsg)    {
            
            
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

                
                
                
                
                
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"FrontDoor"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Permitted"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"WallUnitPic"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"OldTransformerPhoto"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"NewWirePhoto"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"PlanogramPhoto"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"BountiqueAcylicRepairPhoto"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"HeaderAcylicPhoto"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                

                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"FinalDoor"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                

                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"tubeChange"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"tubeQuantity"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"transformerChnged"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cableService"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"visualBountique"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"paintTouchUp"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"planogramIssue"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"BountiqueAcylicRepair"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"BountiqueAcylicRepairDscription"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                
                
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"BountiqueReplaced"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                
                
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"HeaderAcylic"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"DrawerRail"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"drawerRailQuantity"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                
                
                
                             
                
                
            }
            
            
        });
        
    });

    
    
    
    
    
    
    
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

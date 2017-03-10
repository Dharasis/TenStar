//
//  DashBoardVC.m
//  TenStar
//
//  Created by Dharasis on 09/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "DashBoardVC.h"

@interface DashBoardVC ()

@end

@implementation DashBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.navigationController.navigationBar.hidden=YES;
    
      
    //Adding Back Ground Image
    
    _backGrndImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dashboardBackgroundImage"]];
    _backGrndImageView.frame = CGRectMake(0,60, screenRect.size.width, screenRect.size.height);
    
    if(screenRect.size.height>=667){
        
        
        _backGrndImageView.frame = CGRectMake(0 , 80, screenRect.size.width, screenRect.size.height);
    }
    

    
    _backGrndImageView.userInteractionEnabled=true;
   [self.view addSubview:_backGrndImageView];
    
    
//    //Adding Menu Option
//    
//    UIButton *menuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    [menuBtn setBackgroundImage:[UIImage imageNamed:@"MenuBtn"] forState:UIControlStateNormal];
//    menuBtn.frame = CGRectMake(20 , navigationBar.frame.size.height/2-15, 30,30);
//    [ menuBtn addTarget:self action:@selector(toggleMenuVisibility:) forControlEvents:UIControlEventTouchUpInside];
//    [navigationBar addSubview:menuBtn];
//
//    
    


    
    
    //create UI call
                [self createUI];
    // Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    locationManager=nil;
    geocoder = nil;
}

#pragma mark- create UI
-(void)createUI{
    
    self.dashboardTableView = [[UITableView alloc]init];
    
    if(screenRect.size.height<=568)
       self.dashboardTableView.frame = CGRectMake(0, 0, screenRect.size.width, 220);
    else if(screenRect.size.height>=667)
        
         self.dashboardTableView.frame = CGRectMake(0, 0, screenRect.size.width, 380);
        
        else
       self.dashboardTableView.frame = CGRectMake(0, 0, screenRect.size.width, 300);
    
    
    
     if([[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"2"]||[[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"3"] ){
         
    if(screenRect.size.height<=568)
        self.dashboardTableView.frame = CGRectMake(0, 0, screenRect.size.width, 170);
         
    else if(screenRect.size.height>=667)
            
        self.dashboardTableView.frame = CGRectMake(0, 0, screenRect.size.width, 260);
         
    else
        self.dashboardTableView.frame = CGRectMake(0, 0, screenRect.size.width, 230);
         
         

         
         
     }
    
    
    self.dashboardTableView.delegate=self;
    self.dashboardTableView.dataSource=self;
    self.dashboardTableView.scrollEnabled=NO;
    self.dashboardTableView.allowsSelection=NO;
    self.dashboardTableView.backgroundColor = [UIColor clearColor];
    [_backGrndImageView addSubview:self.dashboardTableView];
    
    
    //adding down Arrow
    UIImageView *downArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dashBoardDownArrow"]];
    downArrow.frame = CGRectMake(screenRect.size.width/2 ,0 , 10 , 10);
    [self.dashboardTableView addSubview:downArrow];
    
    //Calculate y axis of Start maintainance Btn
//    float yAxis =(_backGrndImageView.frame.size.height-self.dashboardTableView.frame.origin.y+self.dashboardTableView.frame.size.height)/2;
    
    
    //Start maintainance Button
    UIButton * startMaintainanceBtn;
    

    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"2"])
    {
         startMaintainanceBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       
        
        if(screenRect.size.height>=667){
              startMaintainanceBtn.frame = CGRectMake(40, self.dashboardTableView.frame.origin.y+self.dashboardTableView.frame.size.height+50, screenRect.size.width-80, 80);
        }else
        startMaintainanceBtn.frame = CGRectMake(40, self.dashboardTableView.frame.origin.y+self.dashboardTableView.frame.size.height+50, screenRect.size.width-80, 60);
        [startMaintainanceBtn setBackgroundImage:[UIImage imageNamed:@"StartMaintenanceBtn"] forState:UIControlStateNormal];
        [startMaintainanceBtn addTarget:self action:@selector(startMaintainanceActn:) forControlEvents:UIControlEventTouchUpInside];
        [_backGrndImageView addSubview:startMaintainanceBtn];
        
    }
    
    
}



#pragma mark - Table View Delegate & data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    NSLog(@"Role %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]);
    
      if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"2"]&&![[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"3"] ){
         
          
          return 4;
      }
    else
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    static NSString *CellIdentifier = @"dashboardTableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    if (indexPath.row==0) {
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"1"] ){
        UIButton * addDoorbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        addDoorbutton.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
        [addDoorbutton setBackgroundImage:[UIImage imageNamed:@"AddUpdateDoorBtn"] forState:UIControlStateNormal];
        [addDoorbutton addTarget:self action:@selector(addDoorButtonActn:) forControlEvents:UIControlEventTouchUpInside ];
        
        [cell addSubview:addDoorbutton];
        }else{
            UIButton * doorListButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            doorListButton.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
            [doorListButton addTarget:self action:@selector(doorListBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [doorListButton setBackgroundImage:[UIImage imageNamed:@"DoorListBtn"] forState:UIControlStateNormal];
            [cell addSubview:doorListButton];

        }
        
    }else if (indexPath.row==1){
        
        
        
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"1"] ){
        
            
            
            
            UIButton * doorListButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            doorListButton.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
            [doorListButton addTarget:self action:@selector(doorListBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [doorListButton setBackgroundImage:[UIImage imageNamed:@"DoorListBtn"] forState:UIControlStateNormal];
            [cell addSubview:doorListButton];
            
            
    
        }else{
           
            
            UIButton * notificationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            notificationButton.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
            [notificationButton setBackgroundImage:[UIImage imageNamed:@"notificationBtn"] forState:UIControlStateNormal];
            [notificationButton addTarget:self action:@selector(notificationAction) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:notificationButton];
            

        }

    }else if (indexPath.row==2){
        
        
         if([[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"1"] ){
             
             
             
             UIButton * notificationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
             notificationButton.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
             [notificationButton setBackgroundImage:[UIImage imageNamed:@"notificationBtn"] forState:UIControlStateNormal];
             [notificationButton addTarget:self action:@selector(notificationAction) forControlEvents:UIControlEventTouchUpInside];
             [cell addSubview:notificationButton];

             
                     }
         else{
             UIButton * sosButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
             sosButton.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
             [sosButton setBackgroundImage:[UIImage imageNamed:@"SOSBtn"] forState:UIControlStateNormal];
             [sosButton  addTarget:self action:@selector(sosBtnAction) forControlEvents:UIControlEventTouchUpInside];
             [cell addSubview:sosButton];

               }
        
    }else if (indexPath.row==3){
        
        UIButton * sosButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sosButton.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
        [sosButton setBackgroundImage:[UIImage imageNamed:@"SOSBtn"] forState:UIControlStateNormal];
        [sosButton  addTarget:self action:@selector(sosBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:sosButton];

        
    }
    
    
    return cell;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(screenRect.size.height<=568)
    return 50;
    else if(screenRect.size.height >= 667)
        return 80;
    else
        return 70;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.dashboardTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.dashboardTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.dashboardTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.dashboardTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}



#pragma mark -Start Maintanance Button Action
-(void)startMaintainanceActn:(UIButton *) sender{
    
    [self.navigationController pushViewController:[[MaintenanceVC alloc]init] animated:YES];
    
     //[self replaceVisibleViewControllerWithViewControllerAtIndex:indexPath.row];
    
  //  [[NSNotificationCenter defaultCenter]postNotificationName:@"changeApplicationFrame" object:nil];
    
}

-(void)doorListBtnAction{
    
    
    DoorListVC *doorList = [[DoorListVC alloc]init];
    [self.navigationController pushViewController:doorList animated:YES];


}

-(void)addDoorButtonActn:(UIButton *) sender{
    
    AddDoorVC *addDoor = [[AddDoorVC alloc]init];
    [self.navigationController pushViewController:addDoor animated:YES];
    
    
}

#pragma mark- SOS notiification Action
-(void)sosBtnAction
{
    
    sosCall = YES;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    geocoder = [[CLGeocoder alloc] init];
    [locationManager startUpdatingLocation];
    
    
}
#pragma mark- Notification Action
-(void)notificationAction{
    
    NotificationVC *notification = [[NotificationVC alloc]init];
    [self.navigationController pushViewController:notification animated:YES];

}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
    [self.view makeToast:@"Failed to load location"];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
   // NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
    
        latitude = currentLocation.coordinate.latitude;
        longitude = currentLocation.coordinate.latitude;
        
        
    }
    
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            city = placemark.locality;
            Country = placemark.country;
            
            if (sosCall) {
                
                sosCall = !sosCall;
                [self sorServiceMethod];
            }
            
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
}
-(void)sorServiceMethod{
    
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_ID"];
        
        [APIHelperClass sosNotificationService:userId latitude:[NSString stringWithFormat:@"%f",latitude] longitude:[NSString stringWithFormat:@"%f",longitude] cityName:city country:Country  :^(NSDictionary* responseMsg)    {
            
            
            
            serviceREsponse=[responseMsg objectForKey:@"message"];
            serviceCode=[[responseMsg objectForKey:@"code"]intValue];
            
                     
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            if(serviceREsponse == nil)
                [self.view makeToast:@"Something Went Wrong!!"];
            
            
           
            
            
            
            
            
            if(serviceCode==200){
                
                
                 [self.view makeToast:@"SOS sent successfully!!"];
                
                
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

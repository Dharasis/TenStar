//
//  ViewDoorVC.m
//  TenStar
//
//  Created by Dharasis on 29/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "ViewDoorVC.h"
#import "UIImageView+WebCache.h"

@interface ViewDoorVC (){
    UIImageView* headerView;
    NSArray * headerAr;
    NSArray * paramNameAr;
    NSString* serviceResponse;
    int responseCode;
    UIView* backPopUp,*photoViewPopUp;
    NSDictionary* jsonDict;
    UIScrollView* myScroll;
}

@end

@implementation ViewDoorVC


-(id)init{
    if (self = [super init]){
        
    }
    
    return self;
}
-(id)init:(int)doorID{
    if (self = [super init]){
        
        
        self.doorID = doorID;
        
    }
    
    return self;
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        
        [APIHelperClass fetchDoorDetailService:[NSString stringWithFormat:@"%d",self.doorID] success: ^(NSDictionary* responseMsg)    {
            
            
            
            
            serviceResponse=[responseMsg objectForKey:@"message"];
            responseCode=[[responseMsg objectForKey:@"code"]intValue];
            

            
            if(responseCode==200){
                
                          jsonDict =[responseMsg objectForKey:@"data"];
                
                
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
    
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    jsonDict=nil;
    [myScroll removeFromSuperview];
    [_viewDoorTableView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
    _navigationBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
    _navigationBar.userInteractionEnabled=YES;
    [self.view addSubview:_navigationBar];
    
    headerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DoorDetailHeader"]];
    headerView.frame = CGRectMake(0 , _navigationBar.frame.size.height, screenRect.size.width, 155);
    headerView.userInteractionEnabled=YES;
    [self.view addSubview:headerView];
    
    
    
    
    
    UIButton *menuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"ProfileBackBtn"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(20,10,20,30);
    [ menuBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:menuBtn];
    
   
    //Scroll View
    
    


    // Do any additional setup after loading the view.
}
#pragma mark- Create UI
-(void)createUI{
    
    
    
    myScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headerView.frame.origin.y+headerView.frame.size.height, screenRect.size.width, screenRect.size.height-(headerView.frame.origin.y+headerView.frame.size.height))];
    [myScroll setBackgroundColor:[UIColor clearColor]];
    myScroll.scrollEnabled=YES;
    [self.view addSubview:myScroll];
    

    
    
    //profilePicture
    _doorImg = [[UIImageView alloc]init];
    _doorImg.frame=CGRectMake(headerView.frame.size.width/2
                                       -50, headerView.frame.size.height/2-60, 100, 100);
    _doorImg.userInteractionEnabled=YES;
    _doorImg.layer.cornerRadius = _doorImg.frame.size.width/2;
    _doorImg.clipsToBounds=YES;
    [_doorImg setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:_doorImg];
    
    NSURL *url;
    if([jsonDict  objectForKey:@"shop_picture"] != [NSNull null])
    {
        NSString *urlStr = [[jsonDict  objectForKey:@"shop_picture"] objectAtIndex:0];
       url = [NSURL URLWithString:urlStr];
    }
        // doctorsImg.image = [UIImage imageNamed:@"doctor_img.png"];
        
        
        
        [_doorImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultDoorPic"]];
        

    
    
    //Zoom Button
    UIButton *zoomBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [zoomBtn setBackgroundImage:[UIImage imageNamed:@"zoomImg"] forState:UIControlStateNormal];
    zoomBtn.frame = CGRectMake(_doorImg.frame.origin.x+_doorImg.frame.size.width-30,_doorImg.frame.origin.y+_doorImg.frame.size.height-30,30,30);
    [ zoomBtn addTarget:self action:@selector(zoomAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView
     addSubview:zoomBtn];

    
    
    headerAr = [NSArray arrayWithObjects:@"Door ID",@"Door Name",@"Region",@"Door Status",@"Responsible Person Mobile No",@"Address",@"Client ID",@"Client Name",@"Supervisor ID",@"Supervisor Name",nil];
    paramNameAr = [NSArray arrayWithObjects:@"custom_door_id",@"door_short_name",@"region",@"status",@"responsible_person_ph_no",@"address",@"client_id",@"client_name",@"supervisor_id",@"supervisor_name", nil];
    self.viewDoorTableView = [[UITableView alloc]init];
    self.viewDoorTableView.frame = CGRectMake(0,10, screenRect.size.width, screenRect.size.height-(headerView.frame.origin.y+headerView.frame.size.height));
    self.viewDoorTableView.delegate=self;
    self.viewDoorTableView.dataSource=self;
    self.viewDoorTableView.scrollEnabled=YES;
    self.viewDoorTableView.allowsSelection=NO;
    self.viewDoorTableView.backgroundColor = [UIColor whiteColor];
    [myScroll addSubview:self.viewDoorTableView];
    
    
    
    if(  [[jsonDict  objectForKey:@"status"] isEqual:@"1"]){
    UIButton* viewMaintenance = [[UIButton alloc]init];
    viewMaintenance.frame = CGRectMake(20, self.viewDoorTableView.frame.origin.y+self.viewDoorTableView.frame.size.height+10, myScroll.frame.size.width-40, 40);
    if(screenRect.size.height>=667){
       viewMaintenance.frame = CGRectMake(20, self.viewDoorTableView.frame.origin.y+self.viewDoorTableView.frame.size.height+10, myScroll.frame.size.width-40, 40);
    }
    viewMaintenance.layer.cornerRadius = 2;
    viewMaintenance.backgroundColor = [UIColor colorWithRed:(CGFloat)98/255 green:(CGFloat)89/255 blue:(CGFloat)163/255 alpha:(CGFloat)0.8];
    [viewMaintenance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [viewMaintenance addTarget:self action:@selector(viewMaintenance) forControlEvents:UIControlEventTouchUpInside];
    [viewMaintenance setTitle:@"View Maintenance" forState:UIControlStateNormal];
    [myScroll addSubview:viewMaintenance];
    }
    
    
    float sizeOfContent = 0;
    UIView *lLast = [myScroll.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=20;
    sizeOfContent = wd+ht;
    myScroll.contentSize=CGSizeMake(screenRect.size.width,sizeOfContent+offset);
    
}
#pragma mark - Table View Delegate & data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"count %d",headerAr.count);
    return headerAr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"doorListTableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    
       if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        
      
        

    }
    

    NSLog(@"Text %ld",(long)indexPath.row);
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[headerAr objectAtIndex:indexPath.row]];
    
    
    if([jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]]!=[NSNull null]){
    
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]]];
    }
    
    if([jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]]!=[NSNull null]){
        
        
        if(indexPath.row==2)
        {
              if([[jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]] isEqual:@"1"])
                   cell.detailTextLabel.text=@"East";
                else if ([[jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]] isEqual:@"2"])
                 cell.detailTextLabel.text=@"West";
                else if ([[jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]] isEqual:@"3"])
                 cell.detailTextLabel.text=@"North";
                else if ([[jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]] isEqual:@"4"])
                    cell.detailTextLabel.text=@"South";
                else if ([[jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]] isEqual:@"5"])
                    cell.detailTextLabel.text=@"Central";
                
                
          
        }
       
          else  if(indexPath.row==3)
            {
                if([[jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]] isEqual:@"0"])
                    
                    
                    cell.detailTextLabel.text=@"Maintenance";
                
                else if ([[jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]] isEqual:@"1"])
                    
                    cell.detailTextLabel.text=@"Completed";
                
                
                
                
            }
    
    
    
        
        
    }
    
    
    cell.detailTextLabel.textColor=[UIColor lightGrayColor];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
     //   NSLog(@"index : %ld",(long)indexPath.row);
//    NSLog(@"detailed %@",[jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]]);
    
   
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
     return 50;
}

#pragma mark - zoom action

-(void)zoomAction{
    
    
    
    backPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    backPopUp.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:backPopUp];
    
    photoViewPopUp=[[UIView alloc]initWithFrame:CGRectMake(10, 800, self.view.frame.size.width-20, self.view.frame.size.height-20)];
    photoViewPopUp.layer.cornerRadius=6.0f;
    photoViewPopUp.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1];
    photoViewPopUp.clipsToBounds = YES;
    photoViewPopUp.layer.shadowColor = [UIColor blackColor].CGColor;
    photoViewPopUp.layer.shadowOffset = CGSizeMake(-2, 2);
    photoViewPopUp.layer.shadowOpacity = 3;
    photoViewPopUp.layer.shadowRadius = 15;
    photoViewPopUp.layer.shadowPath = [UIBezierPath bezierPathWithRect:photoViewPopUp.bounds].CGPath;
    
    [backPopUp addSubview:photoViewPopUp];
    
    
    
    //[self.view insertSubview:letsGetStartedPopUp atIndex:2];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        photoViewPopUp.frame=CGRectMake(30, 60, self.view.frame.size.width-60, self.view.frame.size.height-280);
        backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    }completion:^(BOOL finished){
        
        
        
    }];
    
    
    //profileImage=[[UIImageView alloc]initWithFrame:frame];
    
    
    UIImageView *zoomView =[[UIImageView alloc]init];
    zoomView.frame = CGRectMake(0,0,photoViewPopUp .frame.size.width, photoViewPopUp.frame.size.height);
    
    
    
    
    
    
    
            //NSURL *url = [NSURL URLWithString:[dict objectForKey:@"doctorProfilePicUrl"]];
        
        zoomView.image = _doorImg.image;
        
        
        
        //[zoomView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];

    
    
    
    
    
    
    [photoViewPopUp addSubview:zoomView];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(clickOutside:)];
    [backPopUp addGestureRecognizer:tap];
    
    
    
    


}






- (void)clickOutside:(UIGestureRecognizer *)gestureRecognizer

{
   
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        photoViewPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        
        
        
        
    }];
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60;
}


#pragma mark- View Maintenence
-(void)viewMaintenance{
    
    ViewMaintenance *viewMaintenance = [[ViewMaintenance alloc]init:_doorID];
    [self.navigationController pushViewController:viewMaintenance animated:YES];

}

#pragma mark- Back Button Action
-(void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
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

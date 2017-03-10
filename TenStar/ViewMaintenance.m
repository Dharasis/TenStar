//
//  ViewMaintenance.m
//  TenStar
//
//  Created by Dharasis on 24/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "ViewMaintenance.h"
#import "UIImageView+WebCache.h"
@interface ViewMaintenance (){
    NSString* serviceResponse;
    int responseCode;
    NSDictionary* jsonDict,*jsonDictMaintenance;
    UIImageView* headerView;
    UIImageView* buttomBar;
    NSArray *notPermitedHeader,*notPermitedParam,*permitedHeder,*permitedParam;
    UIView* backPopUp,*photoViewPopUp;
    UIScrollView* myScroll;

}

@end

@implementation ViewMaintenance

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
    
    myScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headerView.frame.origin.y+headerView.frame.size.height, screenRect.size.width, screenRect.size.height-(headerView.frame.origin.y+headerView.frame.size.height))];
    [myScroll setBackgroundColor:[UIColor clearColor]];
    myScroll.scrollEnabled=YES;
    [self.view addSubview:myScroll];
    
    
    

    // Do any additional setup after loading the view.
}

-(void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    
    
     semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        
        [APIHelperClass  viewDoorMaintenanceService :[NSString stringWithFormat:@"%d",self.doorID] : ^(NSDictionary* responseMsg)    {
            
            
            
            
//            serviceResponse=[responseMsg objectForKey:@"message"];
//            responseCode=;
            
            
            
            if([[responseMsg objectForKey:@"code"]intValue]==200){
                
                jsonDictMaintenance =[responseMsg objectForKey:@"data"];
                
                
            }
            
            
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
            
            if([[jsonDictMaintenance objectForKey:@"permitted"]isEqual:@"0"])
                [self createNotPermitedTableView];
            else
                [self createPermitedTableView];
            

            
            
          
            
            if(serviceResponse == nil)
                [self.view makeToast:@"Something Went Wrong!!"];
            
            
            
            
        });
        
        
        
    });
    
    
}


-(void)createUI{
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
    
    
    
    

}

#pragma mark - next Action
-(void)nextAction{
    
    ViewMaintenancePhoto *viewMaintenancePhoto = [[ViewMaintenancePhoto alloc]init:[jsonDictMaintenance objectForKey:@""] frontshopPic:[jsonDictMaintenance objectForKey:@"front_shop_picture"] wallPic:[jsonDictMaintenance objectForKey:@"pictures_of_wall"] oldTransformerPic:[jsonDictMaintenance objectForKey:@"old_transformer_picture"] newWirePic:[jsonDictMaintenance objectForKey:@"picture_of_new_wire"] planogramPic:[jsonDictMaintenance objectForKey:@"planogram_picture"] bountiqueAcyclicPic:[jsonDictMaintenance objectForKey:@"boutique_acrylic_repair_picture"]  headerAcyicPic:[jsonDictMaintenance objectForKey:@"header_acrylic_picture"] finalPic:[jsonDictMaintenance objectForKey:@"door_complete_final_picture"]];
    [self.navigationController pushViewController:viewMaintenancePhoto animated:YES];
}

#pragma mark - create permitted table view
-(void)createPermitedTableView{
    
    
    
    buttomBar = [[UIImageView alloc]init];
    buttomBar.frame=CGRectMake(0, screenRect.size.height-50, screenRect.size.width, 50);
    buttomBar.userInteractionEnabled=YES;
    buttomBar.image = [UIImage imageNamed:@"buttonBarDoorList"];
    [self.view addSubview:buttomBar];
    //75,69,125
    
    //Next Button
    UIButton *nextBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextBtn.frame = CGRectMake(buttomBar.frame.size.width/2-30,5,70,buttomBar.frame.size.height-10);
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)75/255 green:(CGFloat)69/255 blue:(CGFloat)125/255 alpha:1]];
    [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [buttomBar
     addSubview:nextBtn];

    
    permitedHeder = [NSArray arrayWithObjects:@"Door Permitted?",@"Tube Changed?",@"Tube Quantity",@"Transformer Changed?",@"Cable Service Required",@"Visual Bountique Replaced?",@"Bountique Quantity?",@"Paint touch-Up?",@"Planogram Issue",@"Bountique Acrylic Repaired?",@"Description",@"Bountique Acrylic Replaced?",@"Header Acrylic Replaced?",@"Drawer Rail Replaced?",@"Drawer Rail Quantity?",nil];
    permitedParam = [NSArray arrayWithObjects:@"permitted",@"tube_changed",@"tube_quantity",@"transformer_changed",@"cable_service_required",@"visual_boutique_replaced",@"boutique_quantity",@"paint_touch_up",@"planogram_issue",@"boutique_acrylic_repair",@"boutique_acrylic_description",@"boutique_acrylic_replace",@"header_acrylic_replace",@"drawer_rails_replaced",@"drawer_rails_quantity",nil];
    self.permitedTableView = [[UITableView alloc]init];
    self.permitedTableView.frame = CGRectMake(0,headerView.frame.origin.y+headerView.frame.size.height+10, screenRect.size.width, screenRect.size.height-(headerView.frame.origin.y+headerView.frame.size.height+buttomBar.frame.size.height+10));
    self.permitedTableView.delegate=self;
    self.permitedTableView.dataSource=self;
    self.permitedTableView.scrollEnabled=YES;
    self.permitedTableView.allowsSelection=NO;
    self.permitedTableView.backgroundColor = [UIColor whiteColor];
    self.permitedTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.permitedTableView];
    
}
#pragma mark - Create Not Permitted Table View
-(void)createNotPermitedTableView{
    
    notPermitedHeader = [NSArray arrayWithObjects:@"Door Permitted?",@"Date",@"Shop Picture",nil];
    notPermitedParam = [NSArray arrayWithObjects:@"permitted",@"permitted_date",@"front_shop_picture",nil];
    self.notPermitedTableView = [[UITableView alloc]init];
    self.notPermitedTableView.frame = CGRectMake(0,headerView.frame.origin.y+headerView.frame.size.height+10, screenRect.size.width, screenRect.size.height-(headerView.frame.origin.y+headerView.frame.size.height+10+buttomBar.frame.size.height));
    self.notPermitedTableView.delegate=self;
    self.notPermitedTableView.dataSource=self;
    self.notPermitedTableView.scrollEnabled=YES;
    self.notPermitedTableView.allowsSelection=NO;
    self.notPermitedTableView.backgroundColor = [UIColor whiteColor];
    self.notPermitedTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.notPermitedTableView];

    
    
}

#pragma mark - Table View Delegate & data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_notPermitedTableView)
         return notPermitedHeader.count;
    else
         return permitedHeder.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"maintenanceListTableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        
        
        
        
    }
    
    
    if(tableView==self.notPermitedTableView){
        
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[notPermitedHeader objectAtIndex:indexPath.row]];
        
        
        if(indexPath.row==2){
            
            
            
            UIImageView* frontDoorImageView = [[UIImageView alloc]init];
            
            
            if(screenRect.size.height>=650){
                
            frontDoorImageView.frame = CGRectMake(cell.frame.size.width/2-30, 10, 150, 150);
            }
            else
                 frontDoorImageView.frame = CGRectMake(cell.frame.size.width/2-40, 10, 100, 100);
                
            frontDoorImageView.clipsToBounds = YES;
            frontDoorImageView.userInteractionEnabled=YES;
            frontDoorImageView.layer.cornerRadius = frontDoorImageView.frame.size.width/2;
            frontDoorImageView.clipsToBounds=YES;
            [frontDoorImageView setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:frontDoorImageView];
            
            //Zoom Button
//            UIButton *zoomBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
//            
//            [zoomBtn setBackgroundImage:[UIImage imageNamed:@"zoomImg"] forState:UIControlStateNormal];
//            zoomBtn.frame = CGRectMake(frontDoorImageView.frame.origin.x+frontDoorImageView.frame.size.width-30,frontDoorImageView.frame.origin.y+frontDoorImageView.frame.size.height-30,30,30);
//            [ zoomBtn addTarget:self action:@selector(zoomAction) forControlEvents:UIControlEventTouchUpInside];
//            
//            [cell
//             addSubview:zoomBtn];
            
            if([jsonDictMaintenance objectForKey:[notPermitedParam objectAtIndex:indexPath.row]]!=[NSNull null]&&![[jsonDictMaintenance objectForKey:[notPermitedParam objectAtIndex:indexPath.row]]isEqual: @""]){
                
                
                NSString *urlStr = [jsonDictMaintenance objectForKey:[notPermitedParam objectAtIndex:indexPath.row]];
               NSURL* url = [NSURL URLWithString:urlStr];
//                
//              cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[jsonDictMaintenance objectForKey:[notPermitedParam objectAtIndex:indexPath.row]]];
                
                
                
                
                
        [ frontDoorImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultDoorPic"]];

            }

            
            
        }else{
        
        
        if([jsonDictMaintenance objectForKey:[notPermitedParam objectAtIndex:indexPath.row]]!=[NSNull null]){
     
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[self setString:[jsonDictMaintenance objectForKey:[notPermitedParam objectAtIndex:indexPath.row]]]];
        }
        }
    }
    
  else
  {
      
      if(indexPath.row==10){
          
          
          
          
          if([jsonDictMaintenance objectForKey:[permitedParam objectAtIndex:indexPath.row]]!=[NSNull null]||![[jsonDictMaintenance objectForKey:[permitedParam objectAtIndex:indexPath.row]] isEqual :@"(null)"])
           cell.textLabel.text=[NSString stringWithFormat:@"Description: %@",[self setString:[jsonDictMaintenance objectForKey:[permitedParam objectAtIndex:indexPath.row]]]];
          else
                cell.textLabel.text=@"No Description";
          cell.detailTextLabel.numberOfLines=0;
      }
      
      
      else{
          
          
          
          cell.textLabel.text=[NSString stringWithFormat:@"%@",[permitedHeder objectAtIndex:indexPath.row]];
      
      if([jsonDictMaintenance objectForKey:[permitedParam objectAtIndex:indexPath.row]]!=[NSNull null]||![[jsonDictMaintenance objectForKey:[permitedParam objectAtIndex:indexPath.row]] isEqual :@"(null)"]){
      cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[self setString:[jsonDictMaintenance objectForKey:[permitedParam objectAtIndex:indexPath.row]]]];
      }else{
           cell.detailTextLabel.text=@"No Data";
      }
      
      }
      
  }
    
    
    
  
        
        
    
    
    
    cell.detailTextLabel.textColor=[UIColor lightGrayColor];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
    //   NSLog(@"index : %ld",(long)indexPath.row);
    //    NSLog(@"detailed %@",[jsonDict objectForKey:[paramNameAr objectAtIndex:indexPath.row]]);
    
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView==_notPermitedTableView){
    if(indexPath.row==2)
        return 170;
        return 50;
    }else{
        if(indexPath.row==10)
            return 80;
         return 50;
    }
    
    
    
}


-(NSString*)setString:(NSString*)str{
    
    if([str isEqual:@"0"])
        return @"NO";
    else if([str isEqual:@"1"])
        return @"YES";
    else
        return str;
    
    
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

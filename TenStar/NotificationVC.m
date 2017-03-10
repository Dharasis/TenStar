//
//  NotificationVC.m
//  TenStar
//
//  Created by Dharasis on 03/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "NotificationVC.h"
#import "UIImageView+WebCache.h"

@interface NotificationVC (){
    UIImageView *headView;
    int responseCode;
    NSString *serviceResponse;
    UIImageView * buttomBar;
     UIView* backPopUp,*photoViewPopUp;
    NSMutableArray* jsonDict;
    int no_unreadMsg;
    NSString*  deleteserviceResponse;
    int ReadResponseCode,deleteResponseCode;
    UILabel *unReadLbl;
    float lbl_height;
    BOOL isSeeMore;
    TableViewCell * cell;
}

@end

@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView*  _navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
    _navigationBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
    _navigationBar.userInteractionEnabled=YES;
    [self.view addSubview:_navigationBar];
    
    headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, screenRect.size.width, 155)];
    headView.userInteractionEnabled=YES;
    headView.image = [UIImage imageNamed:@"NotificationHeader"];
    [self.view addSubview:headView];
    
    
    
    
    
    
    //Adding Menu Option
    
    UIButton *menuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"ProfileBackBtn"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(20,10,20,30);
    [ menuBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:menuBtn];
    
    

    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

    
    
    jsonDict =[[NSMutableArray alloc]init];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_ID"];
        [APIHelperClass notificationService:userId : ^(NSDictionary* responseMsg)    {
            
            
            
            
            serviceResponse=[responseMsg objectForKey:@"message"];
            responseCode=[[responseMsg objectForKey:@"code"]intValue];
            
            NSArray *_tempAr = [responseMsg objectForKey:@"data"];
            
            if(responseCode==200){
                
                
                for (int i=0; i<_tempAr.count; i++) {
                    [jsonDict addObject:[_tempAr objectAtIndex:i]];
                }
                
                
            }
            
            
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
            
            
            
            
            [self createUI];
            
            
            
            if(serviceResponse == nil)
                [buttomBar makeToast:@"Something Went Wrong!!"];
            
            [buttomBar makeToast:serviceResponse];
            
            
        });
        
        
        
    });
    
    
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    jsonDict=nil;
    [_notificationTableView removeFromSuperview];
}

#pragma mark- Create UI
-(void)createUI{
    
    
    
    UIImageView * msgView = [[UIImageView alloc]init];
    msgView.frame = CGRectMake(headView.frame.size.width/2+15,15, 40, 40);
    msgView.image = [UIImage imageNamed:@"notificationPopUp"];
    [headView addSubview:msgView];
    
    
    
    
    unReadLbl = [[UILabel alloc]init];
    unReadLbl.frame = CGRectMake(13, 10, 20, 15);
 
    unReadLbl.font = [UIFont systemFontOfSize:14];
    unReadLbl.textColor = [UIColor whiteColor];
    [msgView addSubview:unReadLbl];

    for(int i=0;i<jsonDict.count;i++){
     if([[[jsonDict objectAtIndex:i] objectForKey:@"is_read"] isEqual:@"0"])
         no_unreadMsg++;
         }
    
    unReadLbl.text = [NSString stringWithFormat:@"%d",no_unreadMsg];
    self.notificationTableView = [[UITableView alloc]init];
    self.notificationTableView.frame = CGRectMake(0, headView.frame.origin.y+headView.frame.size.height, screenRect.size.width, screenRect.size.height-(headView.frame.origin.y+headView.frame.size.height)-50);
    self.notificationTableView.delegate=self;
    self.notificationTableView.dataSource=self;
    self.notificationTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.notificationTableView.scrollEnabled=YES;
    self.notificationTableView.allowsSelection=NO;
    self.notificationTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.notificationTableView];
    
    
    buttomBar = [[UIImageView alloc]init];
    buttomBar.frame=CGRectMake(0, screenRect.size.height-50, screenRect.size.width, 50);
    buttomBar.userInteractionEnabled=YES;
    buttomBar.image = [UIImage imageNamed:@"buttonBarDoorList"];
    [self.view addSubview:buttomBar];
    
    
    _scrollBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_scrollBtn setBackgroundImage:[UIImage imageNamed:@"ButtomBarBtn"] forState:UIControlStateNormal];
    _scrollBtn.frame = CGRectMake(buttomBar.frame.size.width/2-50,5,100,40);
    [ _scrollBtn addTarget:self action:@selector(scrollAction) forControlEvents:UIControlEventTouchUpInside];
    [buttomBar addSubview:_scrollBtn];
    
   
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *CellIdentifier = @"doorListTableView";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
     cell =(TableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        
        
        
        float height = [self calculateHeight:[[jsonDict objectAtIndex:indexPath.row] objectForKey:@"message"]];
        
        
        
        cell=[[TableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NotificationTable"];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.containerView.frame = CGRectMake(0,0, _notificationTableView.frame.size.width, height-3);
        
        
        
        NSURL *url;
        
        if([[jsonDict objectAtIndex:indexPath.row] objectForKey:@"image"]!=[NSNull null])
            
            
        {
            NSString *urlStr = [[jsonDict objectAtIndex:indexPath.row] objectForKey:@"image"];
            url = [NSURL URLWithString:urlStr];
        }

        cell.photoView.frame = CGRectMake(15, height/2-20, 40, 40);
        cell.photoView.layer.cornerRadius = cell.photoView.frame.size.width/2;
        [cell.photoView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"notificationUserPhoto"]];
        
        NSString* font = FONT_NAME;
        
        
        cell.notificationLabel.frame = CGRectMake(60, 0, cell.containerView.frame.size.width-200, height);
        if([[jsonDict objectAtIndex:indexPath.row] objectForKey:@"message"]!=[NSNull null])
            
        cell.notificationLabel.text = [NSString stringWithFormat:@"%@",[[jsonDict objectAtIndex:indexPath.row] objectForKey:@"message"]];
        cell.notificationLabel.font = [UIFont fontWithName:font size:14];

        
        cell.seeMoreBtn.frame = CGRectMake(50, cell.containerView.frame.size.height-20, 80, 20);
        
        [cell.seeMoreBtn addTarget:self action:@selector(seeMoreBtnActn:) forControlEvents:UIControlEventTouchUpInside];
        cell.seeMoreBtn.tag = 100+indexPath.row;
        
        cell.timeLabel.frame = CGRectMake(cell.containerView.frame.size.width-130 , cell.containerView.frame.size.height/2-10,150 ,30);
      
        if([[jsonDict objectAtIndex:indexPath.row] objectForKey:@"modified"]!=[NSNull null])
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",[[jsonDict objectAtIndex:indexPath.row] objectForKey:@"modified"]];
        
        cell.deleteBtn.frame = CGRectMake(cell.containerView.frame.size.width-80, cell.containerView.frame.size.height/2+20, 60, 30);
        [cell.deleteBtn addTarget:self action:@selector(deleteNotificationAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteBtn.tag = 300+indexPath.row;

        
        if([[[jsonDict objectAtIndex:indexPath.row] objectForKey:@"is_read"] isEqual:@"0"]){
            
           
            cell.notificationImg.frame = CGRectMake(cell.containerView.frame.size.width-60, 10, 30, 20);
            //cell.notificationImg.tag = 500+indexPath.row;
     
        }
               cell.notificationImg.tag = 200+indexPath.row;
    //    NSLog(@"tag %ld",200+indexPath.row);
        
                
    }
    
    return cell;
}




#pragma mark- Scroll Action
-(void)scrollAction{
    
    
    CGFloat height = self.notificationTableView.contentSize.height - self.notificationTableView.bounds.size.height;
[self.notificationTableView setContentOffset:CGPointMake(0, height) animated:YES];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self calculateHeight:[[jsonDict objectAtIndex:indexPath.row] objectForKey:@"message"]];
}


#pragma mark-calculate height of string
-(CGFloat)calculateHeight:(NSString *)stringData
{
    UILabel * lblDescription=[[UILabel alloc]init];
    lblDescription.font=[UIFont systemFontOfSize:14];
    // Create a paragraph style with the desired line break mode
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    // Create the attributes dictionary with the font and paragraph style
    NSDictionary *attributes = @{
                                 NSFontAttributeName:lblDescription.font,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    // Call boundingRectWithSize:options:attributes:context for the string
    CGRect textRect = [stringData boundingRectWithSize:CGSizeMake(self.view.frame.size.width-170,6000)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:attributes
                                               context:nil];
    
    lbl_height = textRect.size.height;
    
    
    if(lbl_height<70){
        lbl_height=100;
    }

    
    // NSLog(@"height of row %f",height);
    return lbl_height+50;
}


#pragma mark - Table View Delegate & data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return jsonDict.count;
}




#pragma mark- back button Action
-(void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)seeMoreBtnActn:(UIButton*)sender{
    
    
    
     NSString* longMsg = [[jsonDict objectAtIndex:sender.tag-100] objectForKey:@"long_message"];
    
    
    NSString * notificationID = [[jsonDict objectAtIndex:sender.tag-100]objectForKey:@"notification_id"];
    
    float height = [self calculateHeight:longMsg];
    
    if(!isSeeMore){
    
        
        isSeeMore = !isSeeMore;
        
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
              [APIHelperClass readNotificationService:notificationID : ^(NSDictionary* responseMsg)    {
            
            
            
            
            serviceResponse=[responseMsg objectForKey:@"message"];
            ReadResponseCode=[[responseMsg objectForKey:@"code"]intValue];
            
                     
                  
           
            
            
            
            
                  dispatch_semaphore_signal(semaphore);

            
        }];
        
          dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            if(ReadResponseCode==200){
                
                
                if(no_unreadMsg>0){
                    no_unreadMsg--;
                    unReadLbl.text = [NSString stringWithFormat:@"%d",no_unreadMsg];
                }
                

            
                [cell.notificationImg viewWithTag:(sender.tag-100)+20].hidden = YES;
                NSLog(@"tag %d",(sender.tag-100)+200);
                
            }
            backPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
            backPopUp.backgroundColor =[UIColor lightGrayColor];
            [self.view addSubview:backPopUp];
            
            photoViewPopUp=[[UIView alloc]initWithFrame:CGRectMake(30, 800, self.view.frame.size.width-20, height)];
            photoViewPopUp.layer.cornerRadius=6.0f;
            photoViewPopUp.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1];
            photoViewPopUp.clipsToBounds = YES;
            photoViewPopUp.layer.shadowColor = [UIColor blackColor].CGColor;
            photoViewPopUp.layer.shadowOffset = CGSizeMake(-2, 2);
            photoViewPopUp.layer.shadowOpacity = 3;
            photoViewPopUp.layer.shadowRadius = 15;
            photoViewPopUp.layer.shadowPath = [UIBezierPath bezierPathWithRect:photoViewPopUp.bounds].CGPath;
            
            [backPopUp addSubview:photoViewPopUp];
            
            
            
            UILabel * lbl = [[UILabel alloc]init];
            lbl.frame = CGRectMake(20, 10, photoViewPopUp.frame.size.width-50, height);
            lbl.text = longMsg;
            lbl.numberOfLines = 0;
            [photoViewPopUp addSubview:lbl];
            
            
            //[self.view insertSubview:letsGetStartedPopUp atIndex:2];
            
            [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                photoViewPopUp.frame=CGRectMake(30, 60, backPopUp.frame.size.width-60, height);
                backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                
                
                
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(dismissPOpUP:)];
                [backPopUp addGestureRecognizer:tap];
                

                
            }completion:^(BOOL finished){
                
                
                
            }];

            
            
            
            
        });
        
        
        
    });

    }
    
  
    
}

#pragma mark- Delete Notification
-(void)deleteNotificationAction:(UIButton*)sender{
    
    
    
    NSString * notificationID = [[jsonDict objectAtIndex:sender.tag-300]objectForKey:@"notification_id"];
    
     dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        [APIHelperClass deleteNotificationService :notificationID : ^(NSDictionary* responseMsg)    {
            
            
            
            
          deleteserviceResponse=[responseMsg objectForKey:@"message"];
            deleteResponseCode=[[responseMsg objectForKey:@"code"]intValue];
            
            
            if(deleteResponseCode==200){
                
                NSLog(@"Msg Read  %ld",(long)sender.tag-300);
               
                
                
                
                if(deleteserviceResponse == nil)
                    [buttomBar makeToast:@"Something Went Wrong!!"];
                
               
                

                
            }
            
            
            dispatch_semaphore_signal(semaphore);

            
            
        }];
        
        
           dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
            
            if(deleteResponseCode==200){
            if([[[jsonDict objectAtIndex:sender.tag-300] objectForKey:@"is_read"] isEqual:@"0"]){
               
                if(no_unreadMsg>0){
                    no_unreadMsg--;
                    unReadLbl.text = [NSString stringWithFormat:@"%d",no_unreadMsg];
                }
                

                
            }
            
            [jsonDict removeObjectAtIndex:sender.tag-300];
            
            
            [_notificationTableView reloadData];
            
             [buttomBar makeToast:deleteserviceResponse];
            
            }

            
        });
        
        
        
    });
    

    
    
    
}

- (void)dismissPOpUP:(UIGestureRecognizer *)gestureRecognizer

{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        photoViewPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
        backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished){
        
        isSeeMore=NO;

        
        
    }];
    
    
    
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

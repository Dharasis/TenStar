//
//  DoorListVC.m
//  TenStar
//
//  Created by Dharasis on 28/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "DoorListVC.h"

@interface DoorListVC (){
    
    NSMutableArray *jsonDict;
    NSArray *region,*statusAr;
    UIImageView* headerView;
    int responseCode;
    NSString *serviceResponse,*commentResponse,*statusResp;
    NSString *deleteDoorResponse;
    int deleteDoorCode,commentCode,statusCode;
    UIImageView * buttomBar;
    UIView *backPopUp,*letsGetStartedPopUp;
    UITextView*  myTextView;
    int commentDoorId;
    NSMutableSet* _collapsedSections;
    BOOL firstTime;
    UIPickerView *clientIdPicker,*regionPicker,*StatusPicker;
    NSMutableArray *clientJsonArr;
    int ClientID,RegionNo;
    NSString* Status;
    UILabel *lbl;
    UIToolbar *toolBar,*regionToolBar,*StatusToolBar;
}

@end

@implementation DoorListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
    _navigationBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
    _navigationBar.userInteractionEnabled=YES;
    [self.view addSubview:_navigationBar];
    
    headerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DoorListHeader"]];
    headerView.frame = CGRectMake(0 , _navigationBar.frame.size.height, screenRect.size.width, 155);
    headerView.userInteractionEnabled=YES;
    [self.view addSubview:headerView];
    
    _collapsedSections = [NSMutableSet new];

    
    UIButton *menuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"ProfileBackBtn"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(20,10,20,30);
    [ menuBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:menuBtn];
    
  
    region = [NSArray arrayWithObjects:@"Central",@"North",@"East",@"South",@"West", nil];
    statusAr = [NSArray arrayWithObjects:@"Approved", @"Completed",@"Pending",@"Not Approved",nil];
    
    //pending , completed, approved , and not_approved
    // Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    jsonDict=nil;
    clientJsonArr=nil;
    [_doorListTableView removeFromSuperview];
    [self resetStatusPickerView];
    [self resetRegionPickerView];
    [self resetClientPickerView];
    [_segmentControl removeFromSuperview];
  
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    
    [self fetchCleintDetails];

    [self createUI];

    
    
    jsonDict =[[NSMutableArray alloc]init];
    
}

-(void)fetchDoorList:(NSString*)param1 param2:(NSString*)param2 val1:(NSString*)value1 val2:(NSString*)value2{
    
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [APIHelperClass fetchAllDoorService:param1 val1:value1 param2:param2 val2:value2  : ^(NSDictionary* responseMsg)    {
  
            serviceResponse=[responseMsg objectForKey:@"message"];
            responseCode=[[responseMsg objectForKey:@"code"]intValue];
            
            NSArray *_tempAr = [responseMsg objectForKey:@"data"];
            
        if(responseCode==200){
            if(jsonDict.count!=0)
                [jsonDict removeAllObjects];
                for (int i=0; i<_tempAr.count; i++) {
                    [jsonDict addObject:[_tempAr objectAtIndex:i]];
                }
                
                
            }
            dispatch_semaphore_signal(semaphore);
            
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD  dismiss];
            
            if(serviceResponse == nil)
                [buttomBar makeToast:@"Something Went Wrong!!"];
            
            [buttomBar makeToast:serviceResponse];
            [_doorListTableView reloadData];
             if(jsonDict.count!=0)
                 lbl.hidden=YES;
            else
                lbl.hidden = NO;
            
            
        });
        
        
        
    });
    

    
    
}

#pragma mark- Back Button Action
-(void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createTableView{
    
}

#pragma mark- Create UI
-(void)createUI{
   
   
    
    
    self.segmentControl = [[UISegmentedControl alloc]init];

    
    
    NSString* font = FONT_NAME;
    lbl = [[UILabel alloc]init];
    lbl.frame = CGRectMake(0, screenRect.size.height/2-20, screenRect.size.width-20, 40);
    lbl.textAlignment= NSTextAlignmentCenter;
    lbl.font = [UIFont fontWithName:font size:23];
    lbl.textColor = [UIColor blackColor];
    lbl.text=@"Choose a option";
    [self.view addSubview:lbl];
    

    
    
    self.regionView = [[UIView alloc]init];
    self.regionView.frame = CGRectMake(0, headerView.frame.origin.y+headerView.frame.size.height, screenRect.size.width, screenRect.size.height-(headerView.frame.origin.y+headerView.frame.size.height)-50);
    self.regionView.hidden=YES;
    [self.regionView setBackgroundColor:[UIColor whiteColor]];
  //  [self.view addSubview:self.regionView];
    
    
    self.clientView = [[UIView alloc]init];
    self.clientView.frame = CGRectMake(0, headerView.frame.origin.y+headerView.frame.size.height, screenRect.size.width, screenRect.size.height-(headerView.frame.origin.y+headerView.frame.size.height)-50);
    self.clientView.hidden=YES;
    [self.clientView setBackgroundColor:[UIColor whiteColor]];
   // [self.view addSubview:self.clientView];
    
    
    
    
    
    self.statusView = [[UIView alloc]init];
    self.statusView.frame = CGRectMake(0, headerView.frame.origin.y+headerView.frame.size.height, screenRect.size.width, screenRect.size.height-(headerView.frame.origin.y+headerView.frame.size.height)-50);
    self.statusView.hidden=YES;
    [self.statusView setBackgroundColor:[UIColor whiteColor]];
   // [self.view addSubview:self.statusView];
    
    
  
    
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Status", @"Client", @"Region", nil];
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    self.segmentControl.frame = CGRectMake(10, headerView.frame.origin.y+headerView.frame.size.height+10, screenRect.size.width-20, 50);
    [self.segmentControl addTarget:self action:@selector(mySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    self.segmentControl.tintColor =  [UIColor colorWithRed:(CGFloat)98/255 green:(CGFloat)89/255 blue:(CGFloat)163/255 alpha:(CGFloat)0.8];
    UIFont *objFont = [UIFont fontWithName:font size:15.0f];
    // Add font object to Dictionary
    NSDictionary *dictAttributes = [NSDictionary dictionaryWithObject:objFont forKey:NSFontAttributeName];
    // Set dictionary to the titleTextAttributes
    [self.segmentControl  setTitleTextAttributes:dictAttributes forState:UIControlStateNormal];
    [self.view addSubview:self.segmentControl];

    
    self.doorListTableView = [[UITableView alloc]init];
    self.doorListTableView.frame = CGRectMake(0, _segmentControl.frame.origin.y+_segmentControl.frame.size.height, screenRect.size.width, screenRect.size.height-(_segmentControl.frame.origin.y+_segmentControl.frame.size.height)-50);
    self.doorListTableView.delegate=self;
    self.doorListTableView.dataSource=self;
    self.doorListTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.doorListTableView.scrollEnabled=YES;
    self.doorListTableView.allowsSelection=NO;
    self.doorListTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_doorListTableView];

    
    
    
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

- (void)mySegmentControlAction:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 0) {
        self.statusView.hidden=NO;
        self.clientView.hidden=YES;
        self.regionView.hidden=YES;
        [self resetClientPickerView];
        [self resetRegionPickerView];
        [self enableStatusSelectionPicker];
    }else if (selectedSegment == 1){
        self.statusView.hidden=YES;
        self.clientView.hidden=NO;
        self.regionView.hidden=YES;
        [self enableClientSelectionPicker];
        [self resetRegionPickerView];
        [self resetStatusPickerView];
    }else if(selectedSegment == 2){
        self.statusView.hidden=YES;
        self.clientView.hidden=YES;
        self.regionView.hidden=NO;
        [self resetClientPickerView];
        [self resetStatusPickerView];
        [self enableRegionSelectionPicker];

    }
}


#pragma mark - Client Option
-(void)enableClientSelectionPicker{
    //picker
    
    clientIdPicker = [[UIPickerView alloc]init];
    clientIdPicker.dataSource = self;
    clientIdPicker.delegate = self;
    clientIdPicker.frame = CGRectMake(0, screenRect.size.height-200, screenRect.size.width, 150);
    clientIdPicker.showsSelectionIndicator = YES;
    clientIdPicker.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(done:)];
   toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, clientIdPicker.frame.origin.y-50, clientIdPicker.frame.size.width, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    [self.view addSubview:toolBar];
    [self.view addSubview:clientIdPicker];
}

#pragma mark - Region Option
-(void)enableRegionSelectionPicker{
    
    regionPicker = [[UIPickerView alloc]init];
    regionPicker.dataSource = self;
    regionPicker.delegate = self;
    regionPicker.frame = CGRectMake(0, screenRect.size.height-200, screenRect.size.width, 150);
    
    regionPicker.backgroundColor = [UIColor whiteColor];
    regionPicker.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton2 = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                    target:self action:@selector(doneRegion:)];
    regionToolBar = [[UIToolbar alloc]initWithFrame:
                     CGRectMake(0, regionPicker.frame.origin.y-50, regionPicker.frame.size.width, 50)];
    [regionToolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems2 = [NSArray arrayWithObjects:
                              doneButton2, nil];
    [regionToolBar setItems:toolbarItems2];
    [self.view addSubview:regionToolBar];
    [self.view addSubview:regionPicker];

}

#pragma mark - Status Option
-(void)enableStatusSelectionPicker{
    
    StatusPicker = [[UIPickerView alloc]init];
    StatusPicker.dataSource = self;
    StatusPicker.delegate = self;
    StatusPicker.frame = CGRectMake(0, screenRect.size.height-200, screenRect.size.width, 150);
    StatusPicker.backgroundColor = [UIColor whiteColor];

    StatusPicker.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton3 = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                    target:self action:@selector(doneStatus:)];
    StatusToolBar = [[UIToolbar alloc]initWithFrame:
                     CGRectMake(0, StatusPicker.frame.origin.y-50, StatusPicker.frame.size.width, 50)];
    [StatusToolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems3 = [NSArray arrayWithObjects:
                              doneButton3, nil];
    [StatusToolBar setItems:toolbarItems3];
    [self.view addSubview:StatusToolBar];
    [self.view addSubview:StatusPicker];

    
}


#pragma mark- fetch Client Details
-(void)fetchCleintDetails{
    
    
    clientJsonArr = [[NSMutableArray alloc]init];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [APIHelperClass fetchClientDetails :^(NSDictionary * jsonResponseMsg){
            
            
            //NSLog(@"Respose: %@",jsonResponseMsg);
            clientJsonArr=[jsonResponseMsg objectForKey:@"data"];
            
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            });
        
    });
    
    
    
    
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    if(pickerView==clientIdPicker)
        return [clientJsonArr count];
    else if (pickerView==regionPicker)
        return [region count];
    else if (pickerView==StatusPicker)
        return [statusAr count];
        
    
    return 0;
    
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
    if(pickerView==clientIdPicker)
        ClientID = [[[clientJsonArr objectAtIndex:row] objectForKey:@"ID"]intValue];
    else if (pickerView==regionPicker)
        RegionNo = [self getRegionNo:[region objectAtIndex:row]];
    else if (pickerView==StatusPicker)
        Status = [self getStatus:[statusAr objectAtIndex:row]];
}

#pragma mark - check status
-(NSString*)getStatus:(NSString*)status{
 
    //statusAr = [NSArray arrayWithObjects:@"Approved", @"Completed",@"Pending",@"Not Approved",nil];
    
    if([status isEqual:@"Completed"])
        return  @"completed";
    else if([status isEqual:@"Approved"])
        return  @"approved";
    else if ([status isEqual:@"Pending"])
        return @"pending";
    else if ([status isEqual:@"Not Approved"])
        return @"not_approved";
    return nil;
    
}

#pragma mark - check region
-(int)getRegionNo:(NSString*)regionName{
    
   if([regionName isEqual:@"East"])
        return  1;
   else if([regionName isEqual:@"West"])
        return  2;
   else if([regionName isEqual:@"North"])
        return  3;
   else if([regionName isEqual:@"South"])
        return  4;
   else if([regionName isEqual:@"Central"])
       return  5;
   else return 0;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel;
    pickerLabel = (UILabel*)view;
    NSString* fontName = FONT_NAME;
    if(pickerView==clientIdPicker){

        if (!pickerLabel)
        {
            pickerLabel = [[UILabel alloc] init];
            
            pickerLabel.font = [UIFont fontWithName:fontName size:18];
            
            pickerLabel.textAlignment=NSTextAlignmentCenter;
        }
        
        NSString*  title = [NSString stringWithFormat:@"%@ ,ID - %@",[[clientJsonArr objectAtIndex:row] objectForKey:@"Name"],[[clientJsonArr objectAtIndex:row] objectForKey:@"ID"]]
        ;
        
        [pickerLabel setText:title];

    }
   else if(pickerView==regionPicker){
        
        if (!pickerLabel)
        {
            pickerLabel = [[UILabel alloc] init];
            
            pickerLabel.font = [UIFont fontWithName:fontName size:20];
            
            pickerLabel.textAlignment=NSTextAlignmentCenter;
        }
        
        NSString*  title = [region objectAtIndex:row]
        ;
        
        [pickerLabel setText:title];
        
    }
    
   else if(pickerView==StatusPicker){
       
       if (!pickerLabel)
       {
           pickerLabel = [[UILabel alloc] init];
           
           pickerLabel.font = [UIFont fontWithName:fontName size:20];
           
           pickerLabel.textAlignment=NSTextAlignmentCenter;
       }
       
       NSString*  title = [statusAr objectAtIndex:row]
       ;
       
       [pickerLabel setText:title];
       
   }

    
  
    
    
    return pickerLabel;
}

#pragma mark- Picker done button Action

-(void)done:(UIButton*)sender{
    
    
    if(ClientID==0)
        [self.view makeToast:@"Select a Client ID"];
    
    NSLog(@"Client ID %d",ClientID);
    
    if(jsonDict.count!=0)
        [jsonDict removeAllObjects];
    
    [self fetchDoorList:@"role" param2:@"user_id" val1:@"2" val2:[NSString stringWithFormat:@"%d",ClientID]];
    
    ClientID = 0;
    [self resetClientPickerView];
}
-(void)doneRegion:(UIButton*)sender{
    
    if(RegionNo==0)
        [self.view makeToast:@"Select a Region"];
    
    NSLog(@"Region %d",RegionNo);
    
    if(jsonDict.count!=0)
        [jsonDict removeAllObjects];
   
    [self fetchDoorList:@"region" param2:@"" val1:[NSString stringWithFormat:@"%d",RegionNo] val2:@""];
    
    RegionNo = 0;
        
    [self resetRegionPickerView];
    
}

-(void)doneStatus:(UIButton*)sender{
    
    if(Status == nil)
        [self.view makeToast:@"Select Status"];
    
    NSLog(@"Status %@",Status);
    
    
    if(jsonDict.count!=0)
        [jsonDict removeAllObjects];
    
    [self fetchDoorList:@"status" param2:@"" val1:Status val2:@""];
    
    
    
    Status = nil;
    
    [self resetStatusPickerView];
}


-(void)resetStatusPickerView{
    
    [StatusPicker removeFromSuperview];
    [StatusToolBar removeFromSuperview];

}

-(void)resetRegionPickerView{
    
    
    [regionPicker removeFromSuperview];
    [regionToolBar removeFromSuperview];
}
-(void)resetClientPickerView{
    
    
    [clientIdPicker removeFromSuperview];
    [toolBar removeFromSuperview];
}

#pragma mark- Scroll Action
-(void)scrollAction{

//    CGFloat height = self.doorListTableView.contentSize.height - self.doorListTableView.bounds.size.height;
//    [self.doorListTableView setContentOffset:CGPointMake(0, height) animated:YES];
//    
}
#pragma mark - Table View Delegate & data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return jsonDict.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}





//---------------------------------------------------------------------










//----------------------------------------------------------------------


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"doorListTableView";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
      TableViewCell * cell =(TableViewCell*) [tableView cellForRowAtIndexPath:indexPath];

//    static NSString *CellIdentifier = @"doorListTableView1";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    

    
    if (cell == nil) {
     cell=[[TableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"doorListTableView"];
        // cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
       
        
        if([[jsonDict objectAtIndex:indexPath.row] objectForKey:@"custom_door_id"]!= [NSNull null])
        
        cell.id_label.text=[NSString stringWithFormat:@"Door ID:\t%@",[[jsonDict objectAtIndex:indexPath.row] objectForKey:@"custom_door_id"]];
        
      else
          cell.id_label.text=@"Door ID:";
        cell.id_label.font = [UIFont systemFontOfSize:14];
        
        if([[jsonDict objectAtIndex:indexPath.row] objectForKey:@"door_short_name"]!= [NSNull null])
        cell.name_label.text=[NSString stringWithFormat:@"Door Name: %@",[[jsonDict objectAtIndex:indexPath.row] objectForKey:@"door_short_name"]];
        else
            cell.name_label.text=@"Door Name:";
        cell.name_label.font = [UIFont systemFontOfSize:14];


        
        
        
        if([[[jsonDict objectAtIndex:indexPath.row] objectForKey:@"approved"]isEqual:@"0"]){
            
            cell.approveBtn.hidden = NO;
            cell.approveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
             cell.approveBtn.tag = 6000+indexPath.row;
             cell.approveBtn.titleLabel.text = @"Approve";
            [cell.approveBtn addTarget:self action:@selector(approveActn:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }

     else if([[[jsonDict objectAtIndex:indexPath.row] objectForKey:@"approved"]isEqual:@"1"]){
            
            cell.unapproveBtn.hidden = NO;
            cell.unapproveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            cell.unapproveBtn.tag = 7000+indexPath.row;
         cell.unapproveBtn.titleLabel.text = @"UnApprove";

            [cell.unapproveBtn addTarget:self action:@selector(UnapproveActn:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        
        
        if([[[jsonDict objectAtIndex:indexPath.row] objectForKey:@"status"]isEqual:@"1"]){
            
            
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Door Status: Completed"]];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5,9)];
            
             cell.status_label.text=[NSString stringWithFormat:@"Door Status: Completed"];
            
        }else{
            
            
             NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Door Status: Completed"]];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5,11)];
            cell.status_label.text=[NSString stringWithFormat:@"Door Status: Maintenance"];

        }
              cell.status_label.font = [UIFont systemFontOfSize:14];
     
        cell.view_Door.tag = 100+indexPath.row;
        [cell.view_Door addTarget:self action:@selector(viewDoorAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"1"] ){
        
        cell.update_Door.tag = 200+indexPath.row;
        [cell.update_Door addTarget:self action:@selector(updateDoorAction:) forControlEvents:UIControlEventTouchUpInside];
        }

        
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"1"] ){
        cell.delete_Door.tag = 300+indexPath.row;
        [cell.delete_Door addTarget:self action:@selector(deleteDoorAction:) forControlEvents:UIControlEventTouchUpInside];
        
        }
        
        
        cell.comment.tag = 400+indexPath.row;
        [cell.comment addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        

     
    }
     return cell;
    
}


-(void)approveActn:(UIButton*)sender {
    
    
        int doorId = [[[jsonDict objectAtIndex:sender.tag-6000] objectForKey:@"door_id"]intValue];
    
    [self changeStatus:[NSString stringWithFormat:@"%d",doorId] status:[NSString stringWithFormat:@"%d",0]];
}



-(void)UnapproveActn:(UIButton*)sender {
    
    
        int doorId = [[[jsonDict objectAtIndex:sender.tag-7000] objectForKey:@"door_id"]intValue];
    
    [self changeStatus:[NSString stringWithFormat:@"%d",doorId] status:[NSString stringWithFormat:@"%d",1]];
}


-(void)changeStatus:(NSString*)doorID status:(NSString*)status{
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        
        [APIHelperClass changeDoorStatusService:doorID Doorstatus:status : ^(NSDictionary* responseMsg)    {
            
            
            
            statusResp=[responseMsg objectForKey:@"message"];
            statusCode =[[responseMsg objectForKey:@"code"]intValue];
            
           
            
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            
            
            
            [SVProgressHUD dismiss];
            
            
            
            
            if(deleteDoorResponse == nil)
                [buttomBar makeToast:@"Something Went Wrong!!"];
            
            [buttomBar makeToast:deleteDoorResponse];
            if(responseCode==200)
            {
                [self.view makeToast:@"Door Status Changed!!"];
                [_doorListTableView reloadData];
            }
            //[_doorListTableView reloadData];
            
        });
        
        
        
    });

    
}

#pragma mark- Delete Door
-(void)deleteDoorAction:(UIButton*)sender{
    int doorId = [[[jsonDict objectAtIndex:sender.tag-300] objectForKey:@"door_id"]intValue];
    
    
    [self deleteDoor:doorId tag:sender.tag];

}

#pragma mark- Update Door
-(void)updateDoorAction:(UIButton*)sender
{
    
    int doorId = [[[jsonDict objectAtIndex:sender.tag-200] objectForKey:@"door_id"]intValue];
    
    UpdateDoorVC *updateDoor = [[UpdateDoorVC alloc]init:doorId];
    [self.navigationController pushViewController:updateDoor animated:YES];

    
}

#pragma mark- View Door
-(void)viewDoorAction:(UIButton*)sender{
    
    
    int doorId = [[[jsonDict objectAtIndex:sender.tag-100] objectForKey:@"door_id"]intValue];
    
    ViewDoorVC *viewDoorList = [[ViewDoorVC alloc]init:doorId];
    [self.navigationController pushViewController:viewDoorList animated:YES];
}

#pragma mark- Delete Door Action




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)deleteDoor:(int)doorID tag:(NSInteger)tag{
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        
        [APIHelperClass deleteDoorService :[NSString stringWithFormat:@"%d",doorID] : ^(NSDictionary* responseMsg)    {
            
            
            
            deleteDoorResponse=[responseMsg objectForKey:@"message"];
            deleteDoorCode=[[responseMsg objectForKey:@"code"]intValue];
            
            if(deleteDoorCode==200){
                
                
                          
            }
            
            
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            
            
            
            [SVProgressHUD dismiss];
            
            
            
            
            if(deleteDoorResponse == nil)
                [buttomBar makeToast:@"Something Went Wrong!!"];
            
            [buttomBar makeToast:deleteDoorResponse];
             if(deleteDoorCode==200)
                 [jsonDict removeObjectAtIndex:tag-300];
            //[_doorListTableView reloadData];
            
        });
        
        
        
    });

    
}


#pragma mark- comment Action
-(void)commentAction:(UIButton*)sender{
    
    
    
    int doorId = [[[jsonDict objectAtIndex:sender.tag-400] objectForKey:@"door_id"]intValue];
    
    commentDoorId = doorId;
    backPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 800, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    backPopUp.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:backPopUp];
    
    letsGetStartedPopUp=[[UIView alloc]init];
    letsGetStartedPopUp.frame = CGRectMake(30, 800, self.view.frame.size.width-60, 140);
    letsGetStartedPopUp.layer.cornerRadius=6.0f;
    letsGetStartedPopUp.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1];
    letsGetStartedPopUp.clipsToBounds = YES;
    letsGetStartedPopUp.layer.shadowColor = [UIColor blackColor].CGColor;
    letsGetStartedPopUp.layer.shadowOffset = CGSizeMake(-2, 2);
    letsGetStartedPopUp.layer.shadowOpacity = 3;
    letsGetStartedPopUp.layer.shadowRadius = 15;
    letsGetStartedPopUp.layer.shadowPath = [UIBezierPath bezierPathWithRect:letsGetStartedPopUp.bounds].CGPath;
    
    [backPopUp addSubview:letsGetStartedPopUp];
    
    
    
    //[self.view insertSubview:letsGetStartedPopUp atIndex:2];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        letsGetStartedPopUp.frame=CGRectMake(30, 60, self.view.frame.size.width-60, 140);
        backPopUp.frame=CGRectMake(00, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    }completion:nil];
    
    myTextView = [[UITextView alloc]initWithFrame:
                  CGRectMake(0, 0,letsGetStartedPopUp.frame.size.width, 100)];
    myTextView.backgroundColor = [UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
     myTextView.delegate = self;
    myTextView.text =@"Commet here ...";
     [letsGetStartedPopUp addSubview:myTextView];
    
    
   UIButton* doneBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneBtn.frame=CGRectMake(0,letsGetStartedPopUp.frame.size.height-40,letsGetStartedPopUp.frame.size.width, 40);
    [doneBtn setTitle:@"Done!" forState:UIControlStateNormal];
    doneBtn.titleLabel.font=[UIFont fontWithName:@"GothamRounded-Medium" size:12];
    [doneBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)98/255 green:(CGFloat)89/255 blue:(CGFloat)163/255 alpha:(CGFloat)1]];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneActn:) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.layer.cornerRadius=6.0f;
    
    [letsGetStartedPopUp addSubview:doneBtn];
    


}

#pragma mark - Text View delegates

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:
(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
   textView.text = @"";
}

-(void)doneActn : (UIButton*)sender{
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
      [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_ID"];
        NSString *role =[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"];
        NSString * commentDoorID = [NSString stringWithFormat:@"%d",commentDoorId];
      
        [APIHelperClass commentService:commentDoorID message:myTextView.text userId:userId roles:role   :^(NSDictionary* responseMsg)    {
            
            
            
          
            commentResponse=[responseMsg objectForKey:@"message"];
            commentCode=[[responseMsg objectForKey:@"code"]intValue];
            
            
            
            dispatch_semaphore_signal(semaphore);
            
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            if(commentResponse == nil)
                [self.view makeToast:@"Something Went Wrong!!"];
            else
            
            [self.view makeToast:commentResponse];
            
            
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                letsGetStartedPopUp.frame=CGRectMake(30, 2000, self.view.frame.size.width-60, self.view.frame.size.height-60);
                backPopUp.frame = CGRectMake(0,2000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            }completion:^(BOOL finished){
                [backPopUp removeFromSuperview];
                [letsGetStartedPopUp removeFromSuperview];
                
                
                
                
            }];
            

            
            
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

//
//  SelectDoorVC.m
//  TenStar
//
//  Created by Dharasis on 14/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "SelectDoorVC.h"
#import "SVProgressHUD.h"
@interface SelectDoorVC (){
    
        
        MKPointAnnotation *point;
        MKAnnotationView *annotationView;
        CLLocationCoordinate2D currentUserLocation;
        int completed,incomplete;
        NSString * serviceResponse;
        UILabel * label;
    

}

@end

@implementation SelectDoorVC


-(id)init{
    if (self = [super init]){
        
    }
    
    return self;
}
-(id)init:(NSString*)direction{
    if (self = [super init]){
   
        
        if([direction isEqual:@"north"])
            self.direction=@"North";
        else if ([direction isEqual:@"south"])
            self.direction=@"South";
        else if ([direction isEqual:@"east"])
            self.direction=@"East";
        else if ([direction isEqual:@"west"])
            self.direction=@"West";
        else if ([direction isEqual:@"center"])
            self.direction=@"Central";
            
        
        
    }
    
    return self;
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [_mapUserView removeFromSuperview];

    [_totolDoor removeFromSuperview];
    [_completedDoor removeFromSuperview];
    [_incompletedDoor removeFromSuperview];
    [label removeFromSuperview];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    self.navigationController.navigationBar.hidden=YES;
//    
//    
//    _backGrndImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dashboardBackgroundImage"]];
//    _backGrndImageView.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
//    _backGrndImageView.userInteractionEnabled=YES;
//    [self.view addSubview:_backGrndImageView];
//    
//    
//        
//    
//    //Adding Navigation Bar
//    
//    _navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navigationBar"]];
//    _navigationBar.frame = CGRectMake(0 , 0, screenRect.size.width, 60);
//    _navigationBar.userInteractionEnabled=YES;
//    [_backGrndImageView addSubview:_navigationBar];
//    
//    
//    //Label
//    UILabel *navigationLbl = [[UILabel alloc]init];
//    navigationLbl.textAlignment=NSTextAlignmentCenter;
//    navigationLbl.text=@"MAINTENANCE";
//    navigationLbl.font=[UIFont systemFontOfSize:15];
//    navigationLbl.textColor=[UIColor whiteColor];
//    navigationLbl.frame=CGRectMake(_navigationBar.frame.size.width/2-75, _navigationBar.frame.size.height/2-10, 150, 30);
//    [_navigationBar addSubview:navigationLbl];
//    
//    
//    //Adding Navigation Bar
//    UIButton *menuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    [menuBtn setBackgroundImage:[UIImage imageNamed:@"ProfileBackBtn"] forState:UIControlStateNormal];
//    menuBtn.frame = CGRectMake(20 , _navigationBar.frame.size.height/2-10, 20,30);
//    [ menuBtn addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
//    [_navigationBar addSubview:menuBtn];

    
    
    self.navigationController.navigationBar.hidden=YES;
    
    
    _backGrndImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dashboardBackgroundImage"]];
    _backGrndImageView.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    _backGrndImageView.userInteractionEnabled=YES;
    [self.view addSubview:_backGrndImageView];
    
    
    
    //Adding status Bar
    
    UIImageView *statusBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
    statusBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
    [_backGrndImageView addSubview:statusBar];
    
    
    
    //Adding Navigation Bar
    
    _navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MaintenanceHeader"]];
    _navigationBar.frame = CGRectMake(0 , statusBar.frame.size.height, screenRect.size.width, 40);
    
    if(screenRect.size.height>=667)
        _navigationBar.frame = CGRectMake(0 , statusBar.frame.size.height, screenRect.size.width, 60);
    
    _navigationBar.userInteractionEnabled=YES;
    [_backGrndImageView addSubview:_navigationBar];
    
    
    
    //Adding Navigation Bar
    UIButton *menuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"ProfileBackBtn"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(20 , _navigationBar.frame.size.height/2-15, 20,30);
    [ menuBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBar addSubview:menuBtn];
    

    
    
     _mapUserView=[[UIView alloc]init];
    _mapUserView.frame=CGRectMake(0, _navigationBar.frame.size.height+_navigationBar.frame.origin.y, screenRect.size.width, 250);
    [_backGrndImageView addSubview:_mapUserView];

    
    
    //footer Image
    _footerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectDoorDownImage"]];
    _footerView.frame = CGRectMake(0, _mapUserView.frame.origin.y+_mapUserView.frame.size.height-10, _backGrndImageView.frame.size.width, 40);
    _footerView.userInteractionEnabled=YES;
    [_backGrndImageView addSubview:_footerView];
    
    
    NSString* fontName = FONT_NAME;
    //regionLbl
    
    UILabel * regionlabel =[[UILabel alloc]init];
    regionlabel.frame=CGRectMake(20, _footerView.frame.size.height/2-10, 120, 30);
    regionlabel.text=[NSString stringWithFormat:@"%@ Region",self.direction];
    regionlabel.font=[UIFont fontWithName:fontName size:14];
    regionlabel.textColor=[UIColor whiteColor];
    [_footerView addSubview:regionlabel];
    
    
    //Select Region Lbl
    
    
    
    UILabel * selectRegionlabel =[[UILabel alloc]init];
    selectRegionlabel.frame=CGRectMake(_footerView.frame.size.width-120, _footerView.frame.size.height/2-15, 120, 30);
    selectRegionlabel.text=@"Choose A Door";
    selectRegionlabel.font=[UIFont fontWithName:fontName size:14];
    selectRegionlabel.textColor=[UIColor whiteColor];
    [_footerView addSubview:selectRegionlabel];
    
    
    
    //footer View
    _footer =[[UIView alloc]initWithFrame:CGRectMake(0, _footerView.frame.origin.y+_footerView.frame.size.height, _backGrndImageView.frame.size.width, 40)];
    _footer.backgroundColor=[UIColor whiteColor];
    [_backGrndImageView addSubview:_footer];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _completedDoorAr=[[NSMutableArray alloc]init];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        NSString* region = [NSString stringWithFormat:@"%d", [self getRegionNo:self.direction]];

        [APIHelperClass fetchAllDoorService:@"region" val1:region param2:@"" val2:@"" :^(NSDictionary * jsonResponseMsg){
            
             serviceResponse=[jsonResponseMsg objectForKey:@"message"];
            
            //NSLog(@"Respose: %@",jsonResponseMsg);
            self.jsonAr=[jsonResponseMsg objectForKey:@"data"];
            
          
            
            for (int i=0; i<self.jsonAr.count; i++) {
                
                if([[[self.jsonAr objectAtIndex:i]objectForKey:@"status"]isEqual:@"1"]){
                                        [_completedDoorAr addObject:[[self.jsonAr objectAtIndex:i]objectForKey:@"door_short_name"]];
                    completed++;}
                else
                incomplete++;
            
            
            
            }
            
            
            NSLog(@"door : %lu",(unsigned long)self.jsonAr.count);
            
          
              dispatch_semaphore_signal(semaphore);

            
        }];
           dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            [self createUI];
            
            if(serviceResponse==nil)
                [self.view makeToast:@"Something Went Wrong!!"];
            

            
            
        });
        
    });
    

}




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



#pragma mark- Create UI
-(void)createUI{
   UIView* mapUserView=[[UIView alloc]init];
    mapUserView.frame=CGRectMake(0, _navigationBar.frame.size.height+_navigationBar.frame.origin.y, screenRect.size.width, 250);
    [_backGrndImageView addSubview:mapUserView];
    
    
    _mapView   = [[MKMapView alloc]init];
    _mapView.frame=CGRectMake(0, 0, mapUserView.frame.size.width, mapUserView.frame.size.height);
    
    _mapView.delegate=self;
    
//    _mapView.showsUserLocation=YES;
//    
//    _mapView.mapType = MKMapTypeHybrid;
    
    //    MapClass *mapClass = [[MapClass alloc]init];
    //
    //
    //    MKMapView* mapView = [mapClass createMapView:_mapUserView.frame];
    [mapUserView addSubview:_mapView];
    //
    //    mapView.delegate=self;
    //
    
    
    
    if([_direction isEqual:@"North"])
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(saudiNorthLatitude,saudiNorthLongitude);
    else if ([_direction isEqual:@"South"])
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(saudiSouthLatitude,saudiSouthLongitude);
    else if ([_direction isEqual:@"East"])
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(saudiEastLatitude,saudiEastLongitude);
    else if ([_direction isEqual:@"West"])
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(saudiWestLatitude,saudiWestLongitude);
    else if ([_direction isEqual:@"Central"])
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(saudiLongitude,saudiLatitude);
    

    
    
    
    
    
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
    (_mapView.centerCoordinate, 190000, 190000);
    [_mapView setRegion:region animated:YES];
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate=self;
    
    
    //  we have to setup the location maanager with permission in later iOS versions
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    //[[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
    
    
   NSString* fontName = FONT_NAME;
    
    //Label
    label =[[UILabel alloc]init];
    label.frame=CGRectMake(0, _footerView.frame.size.height/2-15,
                           _footerView.frame.size.width, 30);
    label.text=[NSString stringWithFormat:@"%@ Region Door Status",self.direction];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont fontWithName:fontName size:15];
    label.textColor=[UIColor blueColor];
    [_footer addSubview:label];
    
    

    
    //label
    _totolDoor = [[UILabel alloc]initWithFrame:CGRectMake(0, _footer.frame.origin.y+_footer.frame.size.height+20, _backGrndImageView.frame.size.width, 20)];
    _totolDoor.textAlignment=NSTextAlignmentCenter;
    _totolDoor.textColor=[UIColor whiteColor];
    
    _totolDoor.font=[UIFont fontWithName:fontName size:15];

    [_backGrndImageView addSubview:_totolDoor];
    
    
    //label
    _completedDoor = [[UILabel alloc]initWithFrame:CGRectMake(0, _totolDoor.frame.origin.y+_totolDoor.frame.size.height, _backGrndImageView.frame.size.width,20)];
    _completedDoor.textAlignment=NSTextAlignmentCenter;
    _completedDoor.textColor=[UIColor whiteColor];
    _completedDoor.font=[UIFont fontWithName:fontName size:15];
    [_backGrndImageView addSubview:_completedDoor];
    
    
    //label
    _incompletedDoor = [[UILabel alloc]initWithFrame:CGRectMake(0, _completedDoor.frame.origin.y+_completedDoor.frame.size.height, _backGrndImageView.frame.size.width, 20)];
    _incompletedDoor.textAlignment=NSTextAlignmentCenter;
    _incompletedDoor.textColor=[UIColor whiteColor];
    _incompletedDoor.font=[UIFont fontWithName:fontName size:15];
    [_backGrndImageView addSubview:_incompletedDoor];


    
    _totolDoor.text=[NSString stringWithFormat:@"Total number of Doors   %lu",(unsigned long)self.jsonAr.count];
    _completedDoor.text=[NSString stringWithFormat:@"Completed Doors   %d",completed];
    _incompletedDoor.text=[NSString stringWithFormat:@"InCompleted Doors   %d",incomplete];
    
    

    
}


#pragma mark- Menu action
-(void)menuAction{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark- Back Action
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-continue Action
-(void)continueAction{
    
    
    
    
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    
    [self addAnnotationPoint];

    //    self.locationManager = [[CLLocationManager alloc] init];
    //
    
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    
    
    
        
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
}
-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    
}
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    
    
    
    
    
    
    
    MKPinAnnotationView*  annotationPinView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
    annotationPinView.frame=CGRectMake(0, 0, 60, 150);
    // annotationView.tintColor=[UIColor redColor];
   
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 60)];
    view.backgroundColor=[UIColor blueColor];
    annotationPinView.canShowCallout = YES;
    
    
    //  if([[self.jsonAr objectAtIndex:annota]objectForKey:@"status"]==0)
    
    if([_completedDoorAr containsObject:annotation.title])
        
        annotationPinView.pinTintColor = [UIColor greenColor];
    else
        
        annotationPinView.pinTintColor = [UIColor redColor];
    

    annotationPinView.leftCalloutAccessoryView =view;
    
    
    
    //button
    UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [continueBtn setBackgroundImage:[UIImage imageNamed:@"annotationRightView"] forState:UIControlStateNormal];
    continueBtn.frame = CGRectMake(0, 0, 30, 30);
    annotationPinView.rightCalloutAccessoryView =continueBtn;

    
    
    return annotationPinView;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
   
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKPinAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    
    CustomAnnotation *annotation = (CustomAnnotation*)[mapView.selectedAnnotations objectAtIndex:0];
    ;
    
    
//    NSLog(@"id %d",annotation.doorId);
//    NSLog(@"Door name %@",annotation.title);
    
    
    Maintenance_1 *maintenance_1 = [[Maintenance_1 alloc]init:annotation.title Doorid:annotation.doorId ];
    [self.navigationController pushViewController:maintenance_1 animated:YES];
    
    
    // get annotation details here.
}

//- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
//{
//    MKAnnotationView *annotationViews = [views objectAtIndex:0];
//    id <MKAnnotation> mp = [annotationViews annotation];
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
//    ([mp coordinate], 1000000, 1000000);
//    [mv setRegion:region animated:YES];
//    [mv selectAnnotation:mp animated:YES];
//}


#pragma mark- List of door Service
-(void)addAnnotationPoint{
    
    
    
    CLLocationCoordinate2D location;
    for (int i=0; i<self.jsonAr.count; i++) {
        
        if([[self.jsonAr objectAtIndex:i]objectForKey:@"latitude"]!=[NSNull null])
        
        location.latitude = [[[self.jsonAr objectAtIndex:i]objectForKey:@"latitude"] floatValue];
        
        if([[self.jsonAr objectAtIndex:i]objectForKey:@"longitude"]!=[NSNull null])

        location.longitude = [[[self.jsonAr objectAtIndex:i]objectForKey:@"longitude"]floatValue ];
        
        
//        point   = [[MKPointAnnotation alloc] init];
//        point.coordinate = location;
//        point.title = [[self.jsonAr objectAtIndex:i]objectForKey:@"door_short_name"];
//        point.subtitle = [[self.jsonAr objectAtIndex:i]objectForKey:@"address"];
    
        
        CustomAnnotation*    customPoint   = [[CustomAnnotation alloc] init];
                customPoint.coordinate = location;
                customPoint.title = [[self.jsonAr objectAtIndex:i]objectForKey:@"door_short_name"];
//                customPoint.subtitle = [[self.jsonAr objectAtIndex:i]objectForKey:@"address"];
        customPoint.doorId = [[[self.jsonAr objectAtIndex:i]objectForKey:@"door_id"]intValue];
        
        if([[self.jsonAr objectAtIndex:i]objectForKey:@"address"]!=[NSNull null]){
            
            NSUInteger characterCount = [[[self.jsonAr objectAtIndex:i]objectForKey:@"address"] length];
            
            if(characterCount>20){
                //            [yourString addAttribute:NSUnderlineStyleSingle value:[UIColor blackColor] range:NSMakeRange(0, 20)];
                
                NSString *mystring = [[self.jsonAr objectAtIndex:i]objectForKey:@"address"];
                NSString *newString = [mystring substringToIndex:20];
                //NSLog(@"%@", newString);
                
                customPoint.subtitle = [NSString stringWithFormat:@"%@..",newString];
            }else
                customPoint.subtitle = [[self.jsonAr objectAtIndex:i]objectForKey:@"address"];
            
        }
        

        
        
        
        [self.mapView addAnnotation:customPoint];
    }
    
    

    
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

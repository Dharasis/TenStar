//
//  MaintenanceVC.m
//  TenStar
//
//  Created by Dharasis on 09/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "MaintenanceVC.h"

@interface MaintenanceVC (){
    NSString * serviceResponse;
}

@end

@implementation MaintenanceVC{
    
    MKPointAnnotation *point;
    MKAnnotationView *annotationView;
    CLLocationCoordinate2D currentUserLocation;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Adding Back Ground Image
    
    
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

    

    

    
    // Do any additional setup after loading the view.
}



#pragma mark- Back Action
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    _completedDoor=nil;
    [_mapUserView removeFromSuperview];
    
    [_chooseRegion removeFromSuperview];
    [_chooseDirection removeFromSuperview];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    _completedDoor=[[NSMutableArray alloc]init];
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [APIHelperClass listOfDoorService :^(NSDictionary * jsonResponseMsg){
            
              serviceResponse=[jsonResponseMsg objectForKey:@"message"];
            //NSLog(@"Respose: %@",jsonResponseMsg);
            self.jsonAr=[jsonResponseMsg objectForKey:@"data"];
            
            for (int i=0; i<self.jsonAr.count; i++) {
              
                if([[[self.jsonAr objectAtIndex:i]objectForKey:@"status"]isEqual:@"1"])
                    [_completedDoor addObject:[[self.jsonAr objectAtIndex:i]objectForKey:@"door_short_name"]];
                

            }
            
            
            //    NSLog(@"Door response %@",self.jsonAr);
            
            
            
            
            
            
            
                    //[self addAnnotationPoint];
            
            
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self mapViewDisplay];
            
    
            if(serviceResponse==nil)
                [self.view makeToast:@"Something Went Wrong!!"];
           
            
            
        });
        
    });

    _mapUserView=[[UIView alloc]init];
    _mapUserView.frame=CGRectMake(0, _navigationBar.frame.size.height+_navigationBar.frame.origin.y, screenRect.size.width, 200);
    
    
    
    if(screenRect.size.height>=667){
        _mapUserView.frame=CGRectMake(0, _navigationBar.frame.size.height+_navigationBar.frame.origin.y, screenRect.size.width, 250);

    }
    [self.view addSubview:_mapUserView];
    

    _chooseRegion= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chooseRegion"]];
    _chooseRegion.frame = CGRectMake(0 , _mapUserView.frame.size.height+_mapUserView.frame.origin.y, screenRect.size.width, 30);
     if(screenRect.size.height>=667)
         _chooseRegion.frame = CGRectMake(0 , _mapUserView.frame.size.height+_mapUserView.frame.origin.y, screenRect.size.width, 45);
    [_backGrndImageView addSubview:_chooseRegion];
    
    
    
    
   _chooseDirection= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"directionNavigateBtn"]];
    _chooseDirection.userInteractionEnabled=YES;
    _chooseDirection.frame = CGRectMake(_backGrndImageView.frame.size.width/2-80 , _chooseRegion.frame.size.height+_chooseRegion.frame.origin.y+20, 160, 160);
    
    if(screenRect.size.height>=667)
    
     _chooseDirection.frame = CGRectMake(_backGrndImageView.frame.size.width/2-100 , _chooseRegion.frame.size.height+_chooseRegion.frame.origin.y+20, 200, 200              );
    [_backGrndImageView addSubview:_chooseDirection];
    
    
    UIButton * northBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    northBtn.frame = CGRectMake(_chooseDirection.frame.size.width/2-15, 0, 30, 60);
    [northBtn addTarget:self action:@selector(directionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    northBtn.tag=100;
    [northBtn setBackgroundColor:[UIColor clearColor]];
    [_chooseDirection addSubview:northBtn];
    
    
    UIButton * southBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    southBtn.frame = CGRectMake(_chooseDirection.frame.size.width/2-15,northBtn.frame.size.height+40, 30, 60);
    southBtn.tag=200;
    [southBtn addTarget:self action:@selector(directionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [southBtn setBackgroundColor:[UIColor clearColor]];
    [_chooseDirection addSubview:southBtn];
    
    
    
    UIButton * eastBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    eastBtn.frame = CGRectMake(_chooseDirection.frame.size.width-60,_chooseDirection.frame.size.height/2-15, 60, 30
);
        [eastBtn addTarget:self action:@selector(directionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    eastBtn.tag=300;
    [eastBtn setBackgroundColor:[UIColor clearColor]];
    [_chooseDirection addSubview:eastBtn];
    

    
    
    
    UIButton * westBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    westBtn.frame = CGRectMake(0,_chooseDirection.frame.size.height/2-15, 60, 30);
    westBtn.tag=400;
    [westBtn addTarget:self action:@selector(directionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [westBtn setBackgroundColor:[UIColor clearColor]];
    [_chooseDirection addSubview:westBtn];
    
    UIButton * centerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    centerBtn.frame = CGRectMake(_chooseDirection.frame.size.width/2-30,_chooseDirection.frame.size.height/2-30, 60, 60);
    centerBtn.tag=500;
    centerBtn.layer.cornerRadius=centerBtn.frame.size.width/2;
    [centerBtn addTarget:self action:@selector(directionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [centerBtn setBackgroundColor:[UIColor clearColor]];
    [_chooseDirection addSubview:centerBtn];

    
    
    //  [self performSelector:@selector(fetchNearPharmacy) withObject:nil afterDelay:2];
    
    
    
    
}

#pragma mark- Direction Btn Action
-(void)directionBtnAction:(UIButton*)sender{
    
    
    SelectDoorVC *selectDoor;
    
    switch (sender.tag) {
        case 100:
        
            selectDoor = [[SelectDoorVC alloc]init:@"north"];
        
            break;
            
        case 200:
            
             selectDoor = [[SelectDoorVC alloc]init:@"south"];
            break;
            
        case 300:
            
             selectDoor = [[SelectDoorVC alloc]init:@"east"];
            break;
            
        case 400:
            
             selectDoor = [[SelectDoorVC alloc]init:@"west"];
            break;
            
        case 500:
            
            selectDoor = [[SelectDoorVC alloc]init:@"center"];
            break;
            
        default:
            break;
    }
    
 
    [self.navigationController pushViewController:selectDoor animated:YES];
    
    
}


#pragma mark- Display MapView
-(void)mapViewDisplay{
   
    
    
    
   
    _mapView   = [[MKMapView alloc]init];
    _mapView.frame=CGRectMake(0, 0, _mapUserView.frame.size.width, _mapUserView.frame.size.height);
    
    _mapView.delegate=self;
    
    
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(saudiLatitude, saudiLongitude);
    
    
    
         MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
        ( _mapView.centerCoordinate, 1000000, 1000000);
    //    [mapView setRegion:region animated:YES];
    
    
    //MKCoordinateRegion region = MKCoordinateRegionMake(_mapView.centerCoordinate, span);
    
    
   
    [_mapView setRegion:region animated:YES];
    
   // _mapView.showsUserLocation=YES;

   //  _mapView.mapType = MKMapTypeHybrid;
    
//    MapClass *mapClass = [[MapClass alloc]init];
//    
//    
//    MKMapView* mapView = [mapClass createMapView:_mapUserView.frame];
  [_mapUserView addSubview:_mapView];
//    
//    mapView.delegate=self;
//    
    
    
    
   
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate=self;
    
   
    //  we have to setup the location maanager with permission in later iOS versions
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    //[[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
    
    
    
    
}


-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    
    [self addAnnotationPoint];
    
    
    //    self.locationManager = [[CLLocationManager alloc] init];
    //

    
}

//- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(nonnull NSArray<MKAnnotationView *> *)views{
//    
//    MKAnnotationView *annotationViews = [views objectAtIndex:0];
//    id <MKAnnotation> mp = [annotationViews annotation];
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
//    ([mp coordinate], 1500, 1500);
//    [mapView setRegion:region animated:YES];
//    [mapView selectAnnotation:mp animated:YES];
//}

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
    
    if([_completedDoor containsObject:annotation.title])
       
        annotationPinView.pinTintColor = [UIColor greenColor];
    else
    
    annotationPinView.pinTintColor = [UIColor redColor];
    
    
    annotationPinView.leftCalloutAccessoryView =view;
    
    return annotationPinView;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    
    
    
//    currentUserLocation.latitude = 23.8859;
//    currentUserLocation.longitude = 45.0792;
//    
//    
//    MKCoordinateSpan span;
//    span.latitudeDelta=48;
//    span.latitudeDelta=20;
//    
//    
//    
//    
//    MKCoordinateRegion region = MKCoordinateRegionMake(currentUserLocation, span);
//        [[self mapView] setRegion:region animated:YES];
//    
//
//    point   = [[MKPointAnnotation alloc] init];
//    point.coordinate = userLocation.coordinate;
//    
// [self.mapView addAnnotation:point];

    
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





#pragma mark- List of door Service
-(void)addAnnotationPoint{

    for (int i=0; i<self.jsonAr.count; i++) {
     
        
        CLLocationCoordinate2D location;
        
        
        if([[self.jsonAr objectAtIndex:i]objectForKey:@"latitude"] !=[NSNull null]){
        location.latitude = [[[self.jsonAr objectAtIndex:i]objectForKey:@"latitude"] floatValue];
        location.longitude = [[[self.jsonAr objectAtIndex:i]objectForKey:@"longitude"]floatValue ];
        
        }
        point   = [[MKPointAnnotation alloc] init];
        point.coordinate = location;
        point.title = [[self.jsonAr objectAtIndex:i]objectForKey:@"door_short_name"];
       
       
        if([[self.jsonAr objectAtIndex:i]objectForKey:@"address"]!=[NSNull null]){
        
        NSUInteger characterCount = [[[self.jsonAr objectAtIndex:i]objectForKey:@"address"] length];
       
        if(characterCount>20){
//            [yourString addAttribute:NSUnderlineStyleSingle value:[UIColor blackColor] range:NSMakeRange(0, 20)];
            
            NSString *mystring = [[self.jsonAr objectAtIndex:i]objectForKey:@"address"];
            NSString *newString = [mystring substringToIndex:20];
            //NSLog(@"%@", newString);
            
            point.subtitle = [NSString stringWithFormat:@"%@..",newString];
        }else
            point.subtitle = [[self.jsonAr objectAtIndex:i]objectForKey:@"address"];
        
        }

        
//        if([[[self.jsonAr objectAtIndex:i]objectForKey:@"status"]isEqual:@"1"])
//           [_completedDoor addObject:point.title];
        
       // NSLog(@"door list %d",self.jsonAr.count);
        
        
        
        [self.mapView addAnnotation:point];
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

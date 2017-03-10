//
//  ViewMaintenancePhoto.m
//  TenStar
//
//  Created by Dharasis on 27/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "ViewMaintenancePhoto.h"
#import "UIImageView+WebCache.h"
@interface ViewMaintenancePhoto ()
{
    UIImageView* headerView;
    NSArray *photoLblAr;
    NSMutableArray* photoArray;
}

@end

@implementation ViewMaintenancePhoto
-(id)init{
    if (self = [super init]){
        
    }
    
    return self;
}
-(id)init:(NSString*)shopPicture frontshopPic:(NSString*)front_shop_picture wallPic:(NSString*) pictures_of_wall oldTransformerPic:(NSString*)old_transformer_picture newWirePic:(NSString*)picture_of_new_wire planogramPic:(NSString*)planogram_picture bountiqueAcyclicPic:(NSString*)boutique_acrylic_repair_picture headerAcyicPic:(NSString*)header_acrylic_picture finalPic:(NSString*)door_complete_final_picture{
    
    
    if (self = [super init]){
        
        
        _shopPicture = shopPicture;
        _front_shop_picture=front_shop_picture;
        _picture_of_new_wire=picture_of_new_wire;
        _old_transformer_picture=old_transformer_picture;
        _picture_of_new_wire=picture_of_new_wire;
        _planogram_picture=planogram_picture;
        _boutique_acrylic_repair_picture=boutique_acrylic_repair_picture;
        _header_acrylic_picture=header_acrylic_picture;
        _door_complete_final_picture=door_complete_final_picture;
        
       
        photoArray=[[NSMutableArray alloc]init];
        [photoArray insertObject:_front_shop_picture atIndex:0];
        [photoArray insertObject:_picture_of_new_wire atIndex:1];
        [photoArray insertObject:_old_transformer_picture atIndex:2];
        [photoArray insertObject:_picture_of_new_wire atIndex:3];
        [photoArray insertObject:_planogram_picture atIndex:4];
        [photoArray insertObject:_boutique_acrylic_repair_picture atIndex:5];
        [photoArray insertObject:_header_acrylic_picture atIndex:6];
        [photoArray insertObject:_door_complete_final_picture atIndex:7];
        
       
        photoLblAr = [NSArray arrayWithObjects:@"Front Shop picture",@"Picture of newwire",@"Old transformer Picture",@"Picture of new Wire",@"Planogram Picture",@"Boutique acrylic repair Picture",@"Header acrylic Picture",@"Final Door Picture", nil];
        
        
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

    [self createUI];
    
    
    // Do any additional setup after loading the view.
}



-(void)createUI{
    
    
    
    self.photoListTableView = [[UITableView alloc]init];
    self.photoListTableView.frame = CGRectMake(0, headerView.frame.origin.y+headerView.frame.size.height, screenRect.size.width, screenRect.size.height-(headerView.frame.origin.y+headerView.frame.size.height)-50);
    self.photoListTableView.delegate=self;
    self.photoListTableView.dataSource=self;
    self.photoListTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.photoListTableView.scrollEnabled=YES;
    self.photoListTableView.allowsSelection=NO;
    self.photoListTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.photoListTableView
     ];
    
    

    
}



#pragma mark - Table View Delegate & data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return photoArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(screenRect.size.height>=667)
    return 190;
    else
        return 140;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell * cell =(TableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (cell == nil) {
        
        cell=[[TableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"maintenancePhoto"];
        
        cell.backgroundColor = [UIColor clearColor];
        
        
          cell.notificationLabel.text=[photoLblAr objectAtIndex:indexPath.row];
        
        
       
    
        NSURL *url;
        if([photoArray  objectAtIndex:indexPath.row] != [NSNull null]&&![[photoArray  objectAtIndex:indexPath.row] isEqual: @""])
        {
            NSString *urlStr = [photoArray  objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlStr];
            [cell.notificationImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultDoorPic"]];
            
            

        }else{
         
             cell.notificationImg.image=[UIImage imageNamed:@"DefaultDoorPic"];
        }
        // doctorsImg.image = [UIImage imageNamed:@"doctor_img.png"];
        
}

           return cell;
    
}



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

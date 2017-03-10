//
//  Maintenance_1.m
//  TenStar
//
//  Created by Dharasis on 05/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "Maintenance_1.h"

@interface Maintenance_1 (){
    UIImageView *headView;
    UIImageView *profilePhoto;
    NSData* defaultPhotoView;
    
 

}

@end

@implementation Maintenance_1

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
    doorId_label.textAlignment = NSTextAlignmentCenter;
    doorId_label.font=[UIFont fontWithName:fontName size:15];
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
    question.text = @"Select the picture of shop";
    question.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;question.font = [UIFont fontWithName:fontName size:16];
    [self.view addSubview:question];
    

    
    
    profilePhoto = [[UIImageView alloc]init];
    
    if(screenRect.size.width<=320)
        profilePhoto.frame=CGRectMake(screenRect.size.width/2-50, question.frame.origin.y+question.frame.size.height, 100, 100);
    else
        profilePhoto.frame=CGRectMake(screenRect.size.width/2-75, question.frame.origin.y+question.frame.size.height+10, 150, 150);

    profilePhoto.image = [UIImage imageNamed:@"DoorPicFrame"];
    
    profilePhoto.layer.cornerRadius = profilePhoto.frame.size.width/2;
    profilePhoto.clipsToBounds = YES;
    profilePhoto.userInteractionEnabled = YES;
    [self.view addSubview:profilePhoto];
    
    defaultPhotoView =     UIImagePNGRepresentation(profilePhoto.image);
    
    
    
    
    //Camera Button
    UIButton *cameraBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [cameraBtn setBackgroundImage:[UIImage imageNamed:@"pickPhotoCameraImg"] forState:UIControlStateNormal];
    cameraBtn.frame = CGRectMake(profilePhoto.frame.origin.x + profilePhoto.frame.size.width-30,profilePhoto.frame.origin.y+profilePhoto.frame.size.height-50,40,40);
    [ cameraBtn addTarget:self action:@selector(cameraActn) forControlEvents:UIControlEventTouchUpInside];
    [self.view
     addSubview:cameraBtn];
    
    
    
    
}

#pragma mark- Camera Action
-(void)cameraActn{
    UIImagePickerController* cameraPicker = [[UIImagePickerController alloc] init];
    cameraPicker.delegate = self;
    cameraPicker.allowsEditing = YES;
  // cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    cameraPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:cameraPicker animated:YES completion:NULL];
    
}

#pragma mark- Image Picker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    profilePhoto.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}




-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)nextAction{
    

    
//      if([UIImagePNGRepresentation(profilePhoto.image)isEqualToData:defaultPhotoView]){
//        [self.view makeToast:@"Upload the Photo!!"];
//    }else{
//        
    
        [[NSUserDefaults standardUserDefaults] setObject: UIImageJPEGRepresentation(profilePhoto.image, .3) forKey:@"FrontDoor"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        

        
    MAintenance_2ViewController * maintenance_2 = [[MAintenance_2ViewController alloc]init:_doorName Doorid:_doorID];
    [self.navigationController pushViewController:maintenance_2 animated:YES];
    //}
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

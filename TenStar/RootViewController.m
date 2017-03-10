//
//  RootViewController.m
//  TenStar
//
//  Created by Dharasis on 08/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "RootViewController.h"

#define kExposedWidth 200.0
#define kMenuCellID @"MenuCell"

@interface RootViewController ()
@property (nonatomic, strong) UITableView *menu;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) NSArray *menuTitles;

@property (nonatomic, assign) NSInteger indexOfVisibleController;

@property (nonatomic, assign) BOOL isMenuVisible;
@end

@implementation RootViewController


- (id)initWithViewControllers:(NSArray *)viewControllers andMenuTitles:(NSArray *)menuTitles
{
    if (self = [super init])
        
    {
        
       

        
              
        NSAssert(self.viewControllers.count == self.menuTitles.count, @"There must be one and only one menu title corresponding to every view controller!");
        NSMutableArray *tempVCs = [NSMutableArray arrayWithCapacity:viewControllers.count];
        
        self.menuTitles = [menuTitles copy];
        
        for (UIViewController *vc in viewControllers)
        {
            if (![vc isMemberOfClass:[UINavigationController class]])
            {
                [tempVCs addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
            }
            else
                [tempVCs addObject:vc];
            
//            UIBarButtonItem *revealMenuBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(toggleMenuVisibility:)];
//            
//            
//            
            UIViewController *topVC = ((UINavigationController *)tempVCs.lastObject).topViewController;
//            topVC.navigationItem.leftBarButtonItems = [@[revealMenuBarButtonItem] arrayByAddingObjectsFromArray:topVC.navigationItem.leftBarButtonItems];
            
            
            topVC.navigationController.navigationBar.hidden=YES;

            
            
            
            //Adding status Bar
            
            UIImageView *statusBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
            statusBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
            [topVC.view addSubview:statusBar];
            
            
            
            //Adding Navigation Bar
         
            
            if([vc isMemberOfClass:[DashBoardVC class]]){
           UIImageView *navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dashBoardNavigationBar"]];
            navigationBar.userInteractionEnabled=YES;
            navigationBar.frame = CGRectMake(0 , 20, screenRect.size.width, 60);
                if(screenRect.size.height>=667){
                    
                    
                      navigationBar.frame = CGRectMake(0 , 20, screenRect.size.width, 80);
                }
                
                
            [topVC.view addSubview:navigationBar];
                
            
                //Adding Menu Option
                
                UIButton *menuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
                
                [menuBtn setBackgroundImage:[UIImage imageNamed:@"MenuBtn"] forState:UIControlStateNormal];
                menuBtn.frame = CGRectMake(20 , 10, 20,20);
                [ menuBtn addTarget:self action:@selector(toggleMenuVisibility:) forControlEvents:UIControlEventTouchUpInside];
                [navigationBar addSubview:menuBtn];
                
                

          
            }else if ([vc isMemberOfClass:[ProfileVC class]]){
                
                
                
                


            }
            
            
            
            
            
        }
        
        
        self.viewControllers = [tempVCs copy];
        self.menu = [[UITableView alloc] init];
        self.menu.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.menu.scrollEnabled=NO;
        self.menu.delegate = self;
        self.menu.dataSource = self;

        
       ;
        
        
    }
    return self;
}

- (void)toggleMenuVisibility:(id)sender
{
    self.isMenuVisible = !self.isMenuVisible;
    [self adjustContentFrameAccordingToMenuVisibility];
}

- (void)adjustContentFrameAccordingToMenuVisibility
{
    UIViewController *visibleViewController = self.viewControllers[self.indexOfVisibleController];
    
    
    //SHADOW EFFECT
            CALayer *layer = visibleViewController.view.layer;
            layer.shadowOffset = CGSizeMake(1, 1);
            layer.shadowColor = [[UIColor blackColor] CGColor];
            layer.shadowRadius = 8.0f;
            layer.shadowOpacity = 0.80f;
            layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    
    
    
    CGSize size = visibleViewController.view.frame.size;
    
    if (self.isMenuVisible)
    {
        [UIView animateWithDuration:0.5 animations:^{
    visibleViewController.view.frame = CGRectMake(kExposedWidth, 0, size.width, size.height);
        }];
    }
    else
        [UIView animateWithDuration:0.5 animations:^{
            visibleViewController.view.frame = CGRectMake(0, 0, size.width, size.height);
        }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden=YES;

    
    UIImageView *statusBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
    statusBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
    [self.view addSubview:statusBar];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toggleMenuVisibility:) name:@"toggleMenuVisibility" object:nil];
    
    
   
    
    //[self.menu registerClass:[UITableViewCell class] forCellReuseIdentifier:kMenuCellID];
    self.menu.frame = CGRectMake(0, 20,screenRect.size.width-(screenRect.size.width-kExposedWidth), screenRect.size.height);
    [self.view addSubview:self.menu];

    self.indexOfVisibleController = 0;
    UIViewController *visibleViewController = self.viewControllers[0];
    visibleViewController.view.frame = [self offScreenFrame];
    [self addChildViewController:visibleViewController]; // (5)
    [self.view addSubview:visibleViewController.view]; // (6)
    self.isMenuVisible = NO;
    [self adjustContentFrameAccordingToMenuVisibility]; // (7)
    
    
    [self.viewControllers[0] didMoveToParentViewController:self]; // (8)
    
    // Do any additional setup after loading the view.
}

- (void)replaceVisibleViewControllerWithViewControllerAtIndex:(NSInteger)index // (11)
{
    if (index == self.indexOfVisibleController) return;
    UIViewController *incomingViewController = self.viewControllers[index];
    
    

    
    incomingViewController.view.frame = [self offScreenFrame];
    
    
    
    UIViewController *outgoingViewController = self.viewControllers[self.indexOfVisibleController];
    
    
    
    
    CGRect visibleFrame = self.view.bounds;
    
    
    [outgoingViewController willMoveToParentViewController:nil]; // (12)
    
    [self addChildViewController:incomingViewController]; // (13)
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents]; // (14)
    [self transitionFromViewController:outgoingViewController // (15)
                      toViewController:incomingViewController
                              duration:0.5 options:0
                            animations:^{
                                outgoingViewController.view.frame = [self offScreenFrame];
                                
                            }
     
                            completion:^(BOOL finished) {
                                [UIView animateWithDuration:0.5
                                                 animations:^{
                                                     [outgoingViewController.view removeFromSuperview];
                                                     [self.view addSubview:incomingViewController.view];
                                                     incomingViewController.view.frame = visibleFrame;
                                                     [[UIApplication sharedApplication] endIgnoringInteractionEvents]; // (16)
                                                 }];
                                [incomingViewController didMoveToParentViewController:self]; // (17)
                                [outgoingViewController removeFromParentViewController]; // (18)
                                self.isMenuVisible = NO;
                                self.indexOfVisibleController = index;
                            }];
}


// (19):

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0)
    {
        return 150;
    }
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuTitles.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellID];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMenuCellID];
    }
    
    NSLog(@"cell width %f",tableView.frame.size.width);
    
    if(indexPath.row==0){
     
        
        UIImageView* menuImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SideMenuImage"]];
        menuImage.frame = CGRectMake(0,0, tableView.frame.size.width,150);
        menuImage.userInteractionEnabled=true;
        [cell addSubview:menuImage];
        
    }else if (indexPath.row==1){

    _profileButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _profileButton.frame = CGRectMake(0, 0,tableView.frame.size.width,cell.frame.size.height);
        [_profileButton setBackgroundImage:[UIImage imageNamed:@"ProfileBtn_Deselect"] forState:UIControlStateNormal];
          [_profileButton setBackgroundImage:[UIImage imageNamed:@"ProfileBtn_Select"] forState:UIControlStateHighlighted];
        _profileButton.tag = indexPath.row;
        [_profileButton addTarget:self action:@selector(profileBTnAction:)  forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:_profileButton];
        
        
    }else if (indexPath.row==2){
        _updatePassword = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _updatePassword.frame = CGRectMake(0, 0,tableView.frame.size.width,cell.frame.size.height);
        [_updatePassword setBackgroundImage:[UIImage imageNamed:@"UpdatePasswordBtn"] forState:UIControlStateNormal];
        _updatePassword.tag = indexPath.row;
        [_updatePassword addTarget:self action:@selector(profileBTnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:_updatePassword];

        
    }else if (indexPath.row==3){
        
        
        
        _logOutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _logOutButton.frame = CGRectMake(0, 0,tableView.frame.size.width,cell.frame.size.height);
        [_logOutButton setBackgroundImage:[UIImage imageNamed:@"logOutBtn_Deselect"] forState:UIControlStateNormal];
        [_logOutButton setBackgroundImage:[UIImage imageNamed:@"logOutBtn_Select"] forState:UIControlStateSelected];
        [_logOutButton addTarget:self action:@selector(logOutBTnAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:_logOutButton];
        

        
        
        
        
    }
    

    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"clicked %d row",indexPath.row+1);
    
    if(indexPath.row!=3){
        
        [_profileButton setBackgroundImage:[UIImage imageNamed:@"ProfileBtn_Deselect"] forState:UIControlStateNormal];
        [_updatePassword setBackgroundImage:[UIImage imageNamed:@"UpdatePasswordBtn"] forState:UIControlStateNormal];
        

    
    [self replaceVisibleViewControllerWithViewControllerAtIndex:indexPath.row];
        
    }
}

- (CGRect)offScreenFrame
{
    return CGRectMake(self.view.bounds.size.width-(self.view.bounds.size.width-kExposedWidth), 0, self.view.bounds.size.width, self.view.bounds.size.height);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark- Profile Btn Action
-(void)profileBTnAction:(UIButton*)sender{
    
    
    
    if(sender.tag==1){
      [_profileButton setBackgroundImage:[UIImage imageNamed:@"ProfileBtn_Select"] forState:UIControlStateNormal];
        [_updatePassword setBackgroundImage:[UIImage imageNamed:@"UpdatePasswordBtn"] forState:UIControlStateNormal];

        
    }
    else if(sender.tag==2){
        [_updatePassword setBackgroundImage:[UIImage imageNamed:@"UpdatePassSideBtn_select"] forState:UIControlStateNormal];
        [_profileButton setBackgroundImage:[UIImage imageNamed:@"ProfileBtn_Deselect"] forState:UIControlStateNormal];
    }
   [self replaceVisibleViewControllerWithViewControllerAtIndex:sender.tag];

}


#pragma mark- LogOut Button Action
-(void)logOutBTnAction{
    
        self.view.window.rootViewController=[[ViewController alloc]init];
    [self.view.window makeKeyAndVisible];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"user_ID"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"user_Role"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
  
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

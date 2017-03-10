//
//  AppDelegate.m
//  TenStar
//
//  Created by Dharasis on 25/06/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
//    [self.window setRootViewController:nav];
   
//        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
//        [self.window setRootViewController:nav];
//   
    NSLog(@"height %f",screenRect.size.height);
        
//     [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance]setBarTintColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(afterLoginSuccess)
                                                 name:@"loginSuccess" object:nil];
    

    
   
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    ViewController * rootVC = [[ViewController alloc]init];
    UINavigationController *rootNavi = [[UINavigationController alloc]initWithRootViewController:rootVC];
    self.window.rootViewController = rootNavi;
    [self.window makeKeyAndVisible];
    
    
    
    if(([[NSUserDefaults standardUserDefaults]objectForKey:@"user_ID"]!=nil)&&([[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]!=nil)){
        DashBoardVC * dashBoard = [[DashBoardVC alloc]init];
        ProfileVC *profile = [[ProfileVC alloc]init];
        ChangePasswordVC *changePasswordVC =[[ChangePasswordVC alloc]init];
        RootViewController* root =[[RootViewController alloc]initWithViewControllers:@[dashBoard, profile, changePasswordVC] andMenuTitles:@[@"",@"",@""]];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:root];
        
       self.window.rootViewController = navi;
        
    }
    
    
    
    // Override point for customization after application launch.
    return YES;
}

//#pragma mark-Facebook delegate
//
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    return [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                          openURL:url
//                                                sourceApplication:sourceApplication
//                                                       annotation:annotation];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    
 //   [FBSDKAppEvents activateApp];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"FrontDoor"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Permitted"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"WallUnitPic"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"OldTransformerPhoto"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"NewWirePhoto"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"PlanogramPhoto"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"BountiqueAcylicRepairPhoto"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"HeaderAcylicPhoto"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"FinalDoor"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"tubeChange"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"tubeQuantity"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"transformerChnged"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cableService"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"visualBountique"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"paintTouchUp"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"planogramIssue"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"BountiqueAcylicRepair"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"BountiqueAcylicRepairDscription"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"BountiqueReplaced"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"HeaderAcylic"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"DrawerRail"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"drawerRailQuantity"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)afterLoginSuccess{
    
    DashBoardVC * dashBoard = [[DashBoardVC alloc]init];
    ProfileVC *profile = [[ProfileVC alloc]init];
    ChangePasswordVC *changePasswordVC =[[ChangePasswordVC alloc]init];
    RootViewController* root =[[RootViewController alloc]initWithViewControllers:@[dashBoard, profile, changePasswordVC] andMenuTitles:@[@"",@"",@""]];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:root];
    
    self.window.rootViewController = navi;

}


@end

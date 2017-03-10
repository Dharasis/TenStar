//
//  RootViewController.h
//  TenStar
//
//  Created by Dharasis on 08/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaintenanceVC.h"
#import "DashBoardVC.h"
#import "ProfileVC.h"
#import "ViewController.h"

@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



- (id)initWithViewControllers:(NSArray *)viewControllers andMenuTitles:(NSArray *)menuTitles;

@property(nonatomic,strong)UIButton* profileButton;
@property(nonatomic,strong)UIButton* logOutButton;
@property(nonatomic,strong)UIButton* updatePassword;

@end

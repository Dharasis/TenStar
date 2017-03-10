//
//  ViewDoorVC.h
//  TenStar
//
//  Created by Dharasis on 29/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHelperClass.h"
#import "SVProgressHUD.h"
#import "ViewMaintenance.h"
@interface ViewDoorVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImageView * navigationBar;
@property(strong,nonatomic)UITableView *viewDoorTableView;
@property(strong,nonatomic)UIImageView* doorImg;
@property(assign)int doorID;
-(id)init:(int)doorID;
@end

//
//  ViewMaintenance.h
//  TenStar
//
//  Created by Dharasis on 24/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "APIHelperClass.h"
#import "ViewMaintenancePhoto.h"

@interface ViewMaintenance : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(assign)int doorID;
-(id)init:(int)doorID;
@property(nonatomic,strong)UIImageView * navigationBar;
@property(strong,nonatomic)UIImageView* doorImg;
@property(strong,nonatomic)UITableView *notPermitedTableView,*permitedTableView;


@end

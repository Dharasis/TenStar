//
//  NotificationVC.h
//  TenStar
//
//  Created by Dharasis on 03/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "APIHelperClass.h"
#import "SVProgressHUD.h"
@interface NotificationVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView *notificationTableView;
@property(strong,nonatomic)UIButton *scrollBtn;


@end

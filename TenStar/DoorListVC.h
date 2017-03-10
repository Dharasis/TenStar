//
//  DoorListVC.h
//  TenStar
//
//  Created by Dharasis on 28/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHelperClass.h"
#import "TableViewCell.h"
#import "ViewDoorVC.h"
#import "UpdateDoorVC.h"
#import "SVProgressHUD.h"
@interface DoorListVC : UIViewController<UITableViewDelegate,UITextViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIImageView * navigationBar;
@property(strong,nonatomic)UITableView *region_doorListTableView,*client_doorListTableView,*status_doorListTableView,*doorListTableView;
@property(strong,nonatomic)UIView* regionView,*statusView,*clientView;
@property(strong,nonatomic)UISegmentedControl *segmentControl;
@property(strong,nonatomic)UIButton *scrollBtn;


@end

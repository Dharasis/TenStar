//
//  TableViewCell.h
//  TenStar
//
//  Created by Dharasis on 30/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property(nonatomic,strong)UIView * containerView;
@property(nonatomic,strong)UILabel *id_label,*name_label,*status_label,*notificationLabel,*timeLabel;
@property(nonatomic,strong)UIButton *view_Door,*update_Door,*delete_Door,*comment,*deleteBtn,*seeMoreBtn,*approveBtn,*unapproveBtn;
@property(nonatomic,strong)UIImageView* photoView ,*notificationImg;

@end

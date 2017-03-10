//
//  TableViewCell.m
//  TenStar
//
//  Created by Dharasis on 30/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {

        if ([reuseIdentifier isEqualToString:@"doorListTableView"]){
            
            
            self.contentView.backgroundColor = [UIColor clearColor];
            _containerView = [[UIView alloc]init];
            _containerView.frame = CGRectMake(0, 0,screenRect.size.width,135);
            _containerView.backgroundColor=[UIColor colorWithRed:(CGFloat)211/255 green:(CGFloat)211/255 blue:(CGFloat)211/255 alpha:1];
            [self.contentView addSubview:_containerView];
            
            
            _id_label = [[UILabel alloc]init];
            _id_label.frame = CGRectMake(20, 10, self.contentView.frame.size.width, 20);
            _id_label.text=@"";
            _id_label.textColor=[UIColor colorWithRed:(CGFloat)91/255 green:(CGFloat)81/255 blue:(CGFloat)160/255 alpha:1];
            [self.contentView addSubview:_id_label];
            
            
            _name_label = [[UILabel alloc]init];
            _name_label.frame = CGRectMake(20, _id_label.frame.origin.y+_id_label.frame.size.height, self.contentView.frame.size.width, 20);
            _name_label.text=@"";
            _name_label.textColor=[UIColor colorWithRed:(CGFloat)91/255 green:(CGFloat)81/255 blue:(CGFloat)160/255 alpha:1];
            [self.contentView addSubview:_name_label];
            
            
            
            _status_label = [[UILabel alloc]init];
            _status_label.frame = CGRectMake(20, _name_label.frame.origin.y+_name_label.frame.size.height, self.contentView.frame.size.width, 20);
            _status_label.textColor=[UIColor colorWithRed:(CGFloat)91/255 green:(CGFloat)81/255 blue:(CGFloat)160/255 alpha:1];
            _status_label.text=@"";
            [self.contentView addSubview:_status_label];

           
            _view_Door = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            
            if(screenRect.size.height<=568){
                _view_Door.frame = CGRectMake(self.contentView.frame.size.width-90, 10, 80 , 30);
            }
            else if (screenRect.size.height>=667)
                _view_Door.frame = CGRectMake(self.contentView.frame.size.width-70, 10, 100 , 30);
            else{
                _view_Door.frame = CGRectMake(self.contentView.frame.size.width-70, 10, 80 , 30);
            }
            
                    [_view_Door setBackgroundImage:[UIImage imageNamed:@"DoorViewBtn"] forState:UIControlStateNormal];
                    [self.contentView addSubview:_view_Door];
            
            if([[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"1"] ){

            _update_Door = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            if(screenRect.size.height<=568){
            _update_Door.frame = CGRectMake(self.contentView.frame.size.width-90,_view_Door.frame.origin.y+_view_Door.frame.size.height+10, 80 , 30);
            } else if (screenRect.size.height>=667)
                _update_Door.frame = CGRectMake(self.contentView.frame.size.width-70, _view_Door.frame.origin.y+_view_Door.frame.size.height+10, 100 , 30);
            else{
                _update_Door.frame = CGRectMake(self.contentView.frame.size.width-70,_view_Door.frame.origin.y+_view_Door.frame.size.height+10, 80 , 30);
            }
                    [_update_Door setBackgroundImage:[UIImage imageNamed:@"DoorUpdateBtn"] forState:UIControlStateNormal];
                    [self.contentView addSubview:_update_Door];
            }
            
            
            if([[[NSUserDefaults standardUserDefaults]objectForKey:@"user_Role"]isEqual:@"1"] ){

            _delete_Door = [UIButton buttonWithType:UIButtonTypeRoundedRect];
              if(screenRect.size.height<=568){
                    _delete_Door.frame = CGRectMake(self.contentView.frame.size.width-90,_update_Door.frame.origin.y+_update_Door.frame.size.height+10, 80 , 30);
              }else if (screenRect.size.height>=667)
                  _delete_Door.frame = CGRectMake(self.contentView.frame.size.width-70, _update_Door.frame.origin.y+_update_Door.frame.size.height+10, 100 , 30);
              
              else{
                  _delete_Door.frame = CGRectMake(self.contentView.frame.size.width-70,_update_Door.frame.origin.y+_update_Door.frame.size.height+10, 80 , 30);
              }
                    [_delete_Door setBackgroundImage:[UIImage imageNamed:@"DoorDeleteBtn"] forState:UIControlStateNormal];
            [self.contentView addSubview:_delete_Door];
            }
            
                _comment = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    _comment.frame = CGRectMake(20,self.containerView .frame.size.height-40, 80 , 30);
                    [_comment setBackgroundImage:[UIImage imageNamed:@"commentBtn"] forState:UIControlStateNormal];
                    [self.contentView addSubview:_comment];
            
            
            
            _approveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _approveBtn.frame = CGRectMake(120,self.containerView .frame.size.height-40, 80 , 40);
            [_approveBtn setBackgroundColor: [UIColor colorWithRed:(CGFloat)98/255 green:(CGFloat)89/255 blue:(CGFloat)163/255 alpha:(CGFloat)1]];
            [_approveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_approveBtn setTitle:@"Approve" forState:UIControlStateNormal];
            _approveBtn.hidden = YES;
            _approveBtn.layer.cornerRadius = 3.0f;
            [self.contentView addSubview:_approveBtn];
            
            
            
            _unapproveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _unapproveBtn.frame = CGRectMake(120,self.containerView .frame.size.height-40, 80 , 40);
            [_unapproveBtn setBackgroundColor: [UIColor colorWithRed:(CGFloat)153/255 green:(CGFloat)0/255 blue:(CGFloat)0/255 alpha:(CGFloat)0.8]];
            [_unapproveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_unapproveBtn setTitle:@"UnApprove" forState:UIControlStateNormal];

            _unapproveBtn.hidden = YES;
            _unapproveBtn.layer.cornerRadius = 3.0f;
           
            [self.contentView addSubview:_approveBtn];
            
            
            


            
        }
        
        
        
        if ([reuseIdentifier isEqualToString:@"NotificationTable"]){
            
            
            self.contentView.backgroundColor = [UIColor clearColor];
            _containerView = [[UIView alloc]init];
            _containerView.backgroundColor=[UIColor colorWithRed:(CGFloat)211/255 green:(CGFloat)211/255 blue:(CGFloat)211/255 alpha:1];
            [self.contentView addSubview:_containerView];

            self.photoView = [[UIImageView alloc]init];
            self.photoView.clipsToBounds = YES
            ;
            [_containerView addSubview:_photoView];
            
            
            self.notificationImg = [[UIImageView alloc]init];
            self.notificationImg.image = [UIImage imageNamed:@"NewNotificationImg"];
            [_containerView addSubview:self.notificationImg];

            
            _notificationLabel = [[UILabel alloc]init];
            _notificationLabel.textColor = [UIColor blackColor];
            _notificationLabel.numberOfLines = 0;
            _notificationImg.backgroundColor = [UIColor blackColor];
            [_containerView addSubview:_notificationLabel];
            
            
            _timeLabel = [[UILabel alloc]init];
            _timeLabel.textColor = [UIColor colorWithRed:(CGFloat)91/255 green:(CGFloat)81/255 blue:(CGFloat)160/255 alpha:1];
            _timeLabel.font = [UIFont systemFontOfSize:12];

            [_containerView addSubview:_timeLabel];

            
           _seeMoreBtn  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [_seeMoreBtn setBackgroundColor:[UIColor clearColor]];
            [_seeMoreBtn setTitle:@"See More" forState:UIControlStateNormal];
            [_seeMoreBtn setTitleColor:[UIColor colorWithRed:(CGFloat)91/255 green:(CGFloat)81/255 blue:(CGFloat)160/255 alpha:1] forState:UIControlStateNormal];
            [self.contentView addSubview:_seeMoreBtn];
            
            
            
             _deleteBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"notificationDeleteBtn"] forState:UIControlStateNormal];
            [self.contentView addSubview:_deleteBtn];
            
            
            
            
        }
        
        if ([reuseIdentifier isEqualToString:@"maintenancePhoto"]){
            
            
            self.contentView.backgroundColor = [UIColor clearColor];
            _containerView = [[UIView alloc]init];
            _containerView.backgroundColor=[UIColor colorWithRed:(CGFloat)211/255 green:(CGFloat)211/255 blue:(CGFloat)211/255 alpha:1];
            [self.contentView addSubview:_containerView];
            
//            self.photoView = [[UIImageView alloc]init];
//            self.photoView.clipsToBounds = YES
//            ;
//            
//            [_containerView addSubview:_photoView];
            if(screenRect.size.height>=667)

            _containerView.frame = CGRectMake(0, 0, screenRect.size.width, 180);
            
            
            else
              _containerView.frame = CGRectMake(0, 0, screenRect.size.width, 130);
                
            self.notificationImg = [[UIImageView alloc]init];
            self.notificationImg.clipsToBounds= YES;
            [_notificationImg setBackgroundColor:[UIColor whiteColor]];
            
            if(screenRect.size.height>=667)
                _notificationImg.frame = CGRectMake(_containerView.frame.size.width/2-75, 30, 150,150);
            else
                _notificationImg.frame = CGRectMake(_containerView.frame.size.width/2-50, 30, 100,100);
            _notificationImg.layer.cornerRadius = _notificationImg.frame.size.width/2;

            
            [_containerView addSubview:self.notificationImg];
            
            
            _notificationLabel = [[UILabel alloc]init];
            _notificationLabel.textColor = [UIColor blackColor];
            _notificationLabel.numberOfLines = 0;
            _notificationLabel.frame = CGRectMake(10, 10, _containerView.frame.size.width, 30);

            _notificationLabel.font = [UIFont systemFontOfSize:14];
            _notificationImg.backgroundColor = [UIColor blackColor];
            [_containerView addSubview:_notificationLabel];
            
            
                        
            
        }

        
    }
    return self;
}




@end

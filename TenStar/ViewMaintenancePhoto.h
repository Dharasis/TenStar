//
//  ViewMaintenancePhoto.h
//  TenStar
//
//  Created by Dharasis on 27/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
@interface ViewMaintenancePhoto : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSString* shopPicture,*front_shop_picture,*pictures_of_wall,*old_transformer_picture,*picture_of_new_wire,*planogram_picture,*boutique_acrylic_repair_picture,*header_acrylic_picture,*door_complete_final_picture;
-(id)init:(NSString*)shopPicture frontshopPic:(NSString*)front_shop_picture wallPic:(NSString*) pictures_of_wall oldTransformerPic:(NSString*)old_transformer_picture newWirePic:(NSString*)picture_of_new_wire planogramPic:(NSString*)planogram_picture bountiqueAcyclicPic:(NSString*)boutique_acrylic_repair_picture headerAcyicPic:(NSString*)header_acrylic_picture finalPic:(NSString*)door_complete_final_picture;
@property(nonatomic,strong)UIImageView * navigationBar;
@property(strong,nonatomic)UIImageView* doorImg;
@property(strong,nonatomic)UITableView *photoListTableView;
@end

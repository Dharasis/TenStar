//
//  Maintenance_5s.h
//  TenStar
//
//  Created by Dharasis on 06/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Maintenance_6.h"
@interface Maintenance_5s : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)NSString* doorName;
@property(nonatomic,assign)int doorID;
-(id)init:(NSString*)doorName Doorid:(int)doorID;
@end

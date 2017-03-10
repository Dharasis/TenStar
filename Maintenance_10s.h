//
//  Maintenance_10s.h
//  TenStar
//
//  Created by Dharasis on 09/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Maintenance_11.h"
@interface Maintenance_10s : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)NSString* doorName;
@property(nonatomic,assign)int doorID;
-(id)init:(NSString*)doorName Doorid:(int)doorID;

@end

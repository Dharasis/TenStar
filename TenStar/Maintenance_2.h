//
//  Maintenance_2.h
//  TenStar
//
//  Created by Dharasis on 06/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHelperClass.h"
#import "SVProgressHUD.h"
@interface Maintenance_2 : UIViewController<UITextFieldDelegate>
@property(nonatomic,strong)NSString* doorName;
@property(nonatomic,assign)int doorID;
-(id)init:(NSString*)doorName Doorid:(int)doorID;
@end
//
//  Maintenance_16.h
//  TenStar
//
//  Created by Dharasis on 26/10/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Maintenance_13.h"
@interface Maintenance_16 : UIViewController
@property(nonatomic,strong)NSString* doorName;
@property(nonatomic,assign)int doorID;
-(id)init:(NSString*)doorName Doorid:(int)doorID;
@end

//
//  Maintenance_9.h
//  TenStar
//
//  Created by Dharasis on 06/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Maintenance_10.h"
#import "Maintenance_9s.h"
@interface Maintenance_9 : UIViewController
@property(nonatomic,strong)NSString* doorName;
@property(nonatomic,assign)int doorID;
-(id)init:(NSString*)doorName Doorid:(int)doorID;
@end

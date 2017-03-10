//
//  Maintenance_1.h
//  TenStar
//
//  Created by Dharasis on 05/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAintenance_2ViewController.h"

@interface Maintenance_1 : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)NSString* doorName;
@property(nonatomic,assign)int doorID;
-(id)init:(NSString*)doorName Doorid:(int)doorID;
@end

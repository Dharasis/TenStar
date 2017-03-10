//
//  ChangePasswordVC.h
//  TenStar
//
//  Created by Dharasis on 21/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface ChangePasswordVC : UIViewController<UITextFieldDelegate>
@property(strong,nonatomic) UIScrollView* scrollView;
@property(strong,nonatomic) UITextField* oldPasswordTxtFld;
@property(strong,nonatomic) UITextField* passwordTxtFld;
@property(strong,nonatomic) UITextField* agnPasswordTxtFld;
@property(strong,nonatomic) UIButton* updatePasswordBtn;

@end

//
//  ViewController.h
//  TenStar
//
//  Created by Dharasis on 25/06/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHelperClass.h"
#import "DashBoardVC.h"
#import "ProfileVC.h"
#import "ChangePasswordVC.h"
#import "SVProgressHUD.h"

@interface ViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong)UIImageView *headerView;
@property(nonatomic,strong)UIView * loginView;
@property(nonatomic,strong)UIView * signUpView;
@property(nonatomic,strong)UITextField *reEnterPasswordTxtFld;
@property(nonatomic,strong)UITextField * emailTxtFld;
@property(nonatomic,strong)UITextField* userNameTxtFld;
@property(nonatomic,strong)UITextField* passwordTxtFld;
@property(nonatomic,strong)UIButton* loginButton;
@property(nonatomic,strong)UIButton * facebookSignUpBtn;
@property(nonatomic,strong)UIButton* signUpButton;
@property(nonatomic,strong)UIButton* facebookLoginBtn;
@property(nonatomic,strong)UIScrollView* scrollView;

@end


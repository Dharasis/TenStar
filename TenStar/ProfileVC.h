//
//  ProfileVC.h
//  TenStar
//
//  Created by Dharasis on 14/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHelperClass.h"
@interface ProfileVC : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIImageView* profileImageView;
@property(nonatomic,strong)UITextField * nameTxtField;
@property(nonatomic,strong)UITextField * mobileTxtField;
@property(nonatomic,strong)UITextField * optionalMobTxtField;
@property(nonatomic,strong)UITextField * ageTxtField;
@property(nonatomic,strong)UITextField * genderTxtField;
@property(nonatomic,strong)UITextView * addressTxtField;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *editBtn;
@property(nonatomic,strong)UIImageView * nameEditting;
@property(nonatomic,strong)UIImageView * mobileEditting;
@property(nonatomic,strong)UIImageView * optionalMobileEditting;
@property(nonatomic,strong)UIImageView * ageEditting;
@property(nonatomic,strong)UIImageView * genderEditting;
@property(nonatomic,strong)UIImageView * addressEditting;
@property(nonatomic,strong)UIButton* updateProfileBtn;

@end

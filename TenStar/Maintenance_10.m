//
//  Maintenance_10.m
//  TenStar
//
//  Created by Dharasis on 06/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "Maintenance_10.h"

@interface Maintenance_10 ()
{
    UIImageView *headView;
    UIButton * radioBtnYes,*radioBtnNo;
    UIButton *replaceYes,*replaceNo;
    UIScrollView *scrollView;
    UILabel *subQuestions;
    UITextView *describeTxtView;
    BOOL yes;
    UILabel *SecQuestion;
    UILabel *yesLbl,*notLbl;
    BOOL bountiqueReplaced;
    
}

@end

@implementation Maintenance_10

-(id)init{
    if (self = [super init]){
        
    }
    
    return self;
}
-(id)init:(NSString*)doorName Doorid:(int)doorID{
    if (self = [super init]){
        
        _doorID = doorID;
        _doorName = doorName;
        
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView*  _navigationBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusBar"]];
    _navigationBar.frame = CGRectMake(0 , 0, screenRect.size.width, 20);
    _navigationBar.userInteractionEnabled=YES;
    [self.view addSubview:_navigationBar];
    
    headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, screenRect.size.width, 155)];
    headView.userInteractionEnabled=YES;
    headView.image = [UIImage imageNamed:@"MaintenanceExHeader"];
    [self.view addSubview:headView];
    
    

    [self createUI];
    
    // Do any additional setup after loading the view.
}
-(void)createUI{
    
    NSString* fontName = FONT_NAME;

    UIImageView * footerView = [[UIImageView alloc]init];
    footerView.frame = CGRectMake(0, screenRect.size.height-150, screenRect.size.width, 150);
    footerView.userInteractionEnabled = YES;
    
    footerView.image = [UIImage imageNamed:@"MaintainanceFooter"];
    [self.view addSubview:footerView];
    
    
    
    
    //Scroll View
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headView.frame.origin.y+headView.frame.size.height, screenRect.size.width, screenRect.size.height-(headView.frame.size.height+footerView.frame.size.height+30))];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    scrollView.scrollEnabled=YES;
    [self.view addSubview:scrollView];
    
    
    UILabel *doorId_label = [[UILabel alloc]init];
    doorId_label.frame = CGRectMake(0, 10,screenRect.size.width, 20);
    doorId_label.text = [NSString stringWithFormat:@"Door ID - %d",_doorID];
    doorId_label.font=[UIFont fontWithName:fontName size:15];
    doorId_label.textAlignment = NSTextAlignmentCenter;
    doorId_label.textColor = [UIColor whiteColor];
    [footerView addSubview:doorId_label];
    
    
    UILabel *doorName_label = [[UILabel alloc]init];
    doorName_label.frame = CGRectMake(0, doorId_label.frame.origin.y+doorId_label.frame.size.height+10,screenRect.size.width, 20);
    doorName_label.text = [NSString stringWithFormat:@"Door Name - %@",_doorName];
    doorName_label.textAlignment = NSTextAlignmentCenter;
    doorName_label.font=[UIFont fontWithName:fontName size:15];
    doorName_label.textColor = [UIColor whiteColor];
    [footerView addSubview:doorName_label];
    
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(20, footerView.frame.size.height-70, 100, 50);
    [backButton setBackgroundImage:[UIImage imageNamed:@"SelectDoorBackBtn"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:backButton];
    
    
    
    UIButton * nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextButton.frame = CGRectMake(footerView.frame.size.width-130, footerView.frame.size.height-70, 120, 50);
    [nextButton setBackgroundImage:[UIImage imageNamed:@"selectDoorContinue"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:nextButton];
    
    
    
    UILabel *question = [[UILabel alloc]init];
    question.frame = CGRectMake(0,10, screenRect.size.width, 30);
    question.textAlignment = NSTextAlignmentCenter;
    question.text = @"Hotspot Acrylic Repair ?";
    question.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;question.font = [UIFont fontWithName:fontName size:16];
    [scrollView addSubview:question];
    
    
    
    radioBtnYes = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radioBtnYes.frame = CGRectMake(50,question.frame.origin.y+question.frame.size.height+20,20,20);
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    [radioBtnYes addTarget:self action:@selector(radioBtnYesAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:radioBtnYes];
    
    
    UILabel *permittedLbl = [[UILabel alloc]init];
    permittedLbl.frame = CGRectMake(radioBtnYes.frame.origin.x+radioBtnYes.frame.size.width+5,question.frame.origin.y+question.frame.size.height+10, 80, 40);
    permittedLbl.text=@"Yes";
    permittedLbl.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;permittedLbl.font = [UIFont fontWithName:fontName size:16];
    [scrollView addSubview:permittedLbl];
    
    
    radioBtnNo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radioBtnNo.frame = CGRectMake(screenRect.size.width/2+10,question.frame.origin.y+question.frame.size.height+20,20,20);
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [radioBtnNo addTarget:self action:@selector(radioBtnNoAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:radioBtnNo];
    
    
    UILabel *notPermittedLbl = [[UILabel alloc]init];
    notPermittedLbl.frame = CGRectMake(radioBtnNo.frame.origin.x+radioBtnNo.frame.size.width+5,question.frame.origin.y+question.frame.size.height+10, 100, 40);
    notPermittedLbl.text=@"No";
    notPermittedLbl.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;notPermittedLbl.font = [UIFont fontWithName:fontName size:16];
    [scrollView addSubview:notPermittedLbl];
    
    
    
    
    
    subQuestions = [[UILabel alloc]init];
    subQuestions.frame = CGRectMake(20,radioBtnNo.frame.origin.y+radioBtnNo.frame.size.height+10, scrollView.frame.size.width, 40);
    subQuestions.text=@"Describe the nature of repaired\nBoutique";
    subQuestions.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1];
    subQuestions.numberOfLines = 2;
    subQuestions.font = [UIFont fontWithName:fontName size:16];
    //[scrollView addSubview:subQuestions];

    
    describeTxtView = [[UITextView alloc]init];
    describeTxtView.frame = CGRectMake(20, subQuestions.frame.origin.y+subQuestions.frame.size.height+10, scrollView.frame.size.width-40, 60);
    describeTxtView.layer.cornerRadius=5;
    describeTxtView.backgroundColor=[UIColor colorWithRed:(CGFloat)230/255 green:(CGFloat)230/255 blue:(CGFloat)230/255 alpha:1];
        describeTxtView.text=@"Describe here ...";
    describeTxtView.delegate=self;
    describeTxtView.font =[UIFont fontWithName:fontName size:14];

    describeTxtView.textColor=[UIColor grayColor];
 //   [scrollView addSubview:describeTxtView];
    
    
    
    
    
    SecQuestion = [[UILabel alloc]init];
    SecQuestion.frame = CGRectMake(20,describeTxtView.frame.origin.y+describeTxtView.frame.size.height+20, scrollView.frame.size.width, 30);
    SecQuestion.text = @"Has Boutique Acrylic Replaced ?";
    SecQuestion.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;SecQuestion.font = [UIFont fontWithName:fontName size:16];
    [scrollView addSubview:SecQuestion];

    
    
    
    
    
    replaceYes = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    replaceYes.frame = CGRectMake(50,SecQuestion.frame.origin.y+SecQuestion.frame.size.height+10,20,20);
    [replaceYes setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    [replaceYes addTarget:self action:@selector(replaceYesAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:replaceYes];
    
    
    yesLbl = [[UILabel alloc]init];
    yesLbl.frame = CGRectMake(replaceYes.frame.origin.x+replaceYes.frame.size.width+5,SecQuestion.frame.origin.y+SecQuestion.frame.size.height+10, 80, 40);
    yesLbl.text=@"Yes";
    yesLbl.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;yesLbl.font = [UIFont fontWithName:fontName size:16];
    [scrollView addSubview:yesLbl];
    

    
    
    replaceNo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    replaceNo.frame = CGRectMake(scrollView.frame.size.width/2+10,SecQuestion.frame.origin.y+SecQuestion.frame.size.height+20,20,20);
    [replaceNo setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [replaceNo addTarget:self action:@selector(replaceNoAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:replaceNo];
    
    
    notLbl = [[UILabel alloc]init];
    notLbl.frame = CGRectMake(replaceNo.frame.origin.x+replaceNo.frame.size.width+5,SecQuestion.frame.origin.y+SecQuestion.frame.size.height+10, 100, 40);
    notLbl.text=@"No";
    notLbl.textColor  = [UIColor colorWithRed:(CGFloat)54/255 green:(CGFloat)35/255 blue:(CGFloat)147/255 alpha:1]
    ;notLbl.font = [UIFont fontWithName:fontName size:16];
    [scrollView addSubview:notLbl];
    


    
    
    subQuestions.hidden = YES;
    describeTxtView.hidden =YES;
    notLbl.hidden = YES;
    yesLbl.hidden = YES;
    SecQuestion.hidden = YES;
    replaceNo.hidden = YES;
    replaceYes.hidden = YES;

    
    scrollView.scrollEnabled = NO;
    
    float sizeOfContent = 0;
    UIView *lLast = [scrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    NSInteger offset=20;
    sizeOfContent = wd+ht;
    scrollView.contentSize=CGSizeMake(screenRect.size.width,sizeOfContent+offset);
    
    //[self registerForKeyboardNotifications];
    
    yes = NO;
    bountiqueReplaced = NO;
}



-(void)replaceNoAction{
    bountiqueReplaced = NO;
    
    
    [replaceNo setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [replaceYes setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
}
-(void)replaceYesAction{
    
    bountiqueReplaced = YES;
    
    
    
    [replaceYes setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [replaceNo setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
}
#pragma mark-Text View Delelgates
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    textView.text = @"";
    
    return YES;
}
-(void)radioBtnYesAction{
    
    yes = YES;
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    
    
    
    subQuestions.hidden = NO;
    describeTxtView.hidden =NO;
    scrollView.scrollEnabled = YES;
    
    
    notLbl.hidden = NO;
    yesLbl.hidden = NO;
    SecQuestion.hidden = NO;
    replaceNo.hidden = NO;
    replaceYes.hidden = NO;

    

    
   }


-(void)radioBtnNoAction{
    
    yes = NO;
    
    [radioBtnYes setBackgroundImage:[UIImage imageNamed:@"RdioBtn_Deselect"] forState:UIControlStateNormal];
    [radioBtnNo setBackgroundImage:[UIImage imageNamed:@"RadioBtnSelected"] forState:UIControlStateNormal];
    
    
    
    subQuestions.hidden = YES;
    describeTxtView.hidden = YES;
    scrollView.scrollEnabled = NO;
    
    notLbl.hidden = YES;
    yesLbl.hidden = YES;
    SecQuestion.hidden = YES;
    replaceNo.hidden = YES;
    replaceYes.hidden = YES;

    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)nextAction{

    
    NSString* bountiqueAcylic;
    
    if(yes){
        bountiqueAcylic = @"1";
    }else{
        bountiqueAcylic = @"0";
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:bountiqueAcylic forKey:@"BountiqueAcylicRepair"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    if(yes){
        
        [[NSUserDefaults standardUserDefaults] setObject:describeTxtView.text forKey:@"BountiqueAcylicRepairDscription"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString* replaced;
        if(bountiqueReplaced){
            replaced=@"1";
        }else{
            replaced=@"0";
        }
        
        
        [[NSUserDefaults standardUserDefaults] setObject:replaced forKey:@"BountiqueReplaced"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        Maintenance_10s * maintenance_10s = [[Maintenance_10s alloc]init:_doorName Doorid:_doorID];
        [self.navigationController pushViewController:maintenance_10s animated:YES];

        
    }else{
        
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"BountiqueAcylicRepairDscription"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString* replaced;
       
        if(bountiqueReplaced){
            replaced=@"1";
        }else{
            replaced=@"0";
        }
        
        
        [[NSUserDefaults standardUserDefaults] setObject:replaced forKey:@"BountiqueReplaced"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
     
        Maintenance_11 * maintenance_11 = [[Maintenance_11 alloc]init:_doorName Doorid:_doorID];
        [self.navigationController pushViewController:maintenance_11 animated:YES];

        
    }
    
       
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

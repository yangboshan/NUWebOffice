//
//  NUMainViewController.m
//  NUWebOffice
//
//  Created by JY on 14-4-18.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUMainViewController.h"
#import "NULoginViewController.h"
#import "UIButton+Image.h"

#import "IIViewDeckController.h"
#import "NULeftViewController.h"

#define MIDDLE_HEIGHT 60
#define MAIN_BUTTON_WIDTH 105
#define MAIN_BUTTON_HEIGHT 90
#define ROW_ITEMS_COUNT 3.0

@interface NUMainViewController ()

@end

@implementation NUMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self.scrollView setBackgroundColor:[UIColor whiteColor]];
    [self setupTopbar];
    [self setupMiddlebar];
    [self setupFunctionArea];
    
}

#pragma mark - 顶部栏
/*---------------------------------------
 * 顶部栏
 *--------------------------------------*/
-(void)setupTopbar{
    
    UIView* topbar = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              ScreenWidth,
                                                              NavBarHeight)];
    
    UIImageView* head = [[UIImageView alloc] initWithImage:
                         [UIImage imageNamed:@"defaultAvatar"]];
    
    [head setFrame:CGRectMake(5, 5, 40, 40)];
    [topbar addSubview:head];
    
    UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 50, 30)];
    [name setFont:[UIFont systemFontOfSize:15.0]];
    [name setTextAlignment:NSTextAlignmentCenter];
    [name setText:@"周军"];
    [topbar addSubview:name];
    
    UIImageView* rightArrow = [[UIImageView alloc] initWithImage:
                               [UIImage imageNamed:@"ma_rightArrow"]];
    
    [rightArrow setFrame:CGRectMake(ScreenWidth - 30,
                                    15,
                                    24,
                                    17)];
    
    [topbar addSubview:rightArrow];
    
    [self.scrollView addSubview:topbar];
}

#pragma mark - 中部栏
/*---------------------------------------
 * 中部栏
 *--------------------------------------*/
-(void)setupMiddlebar{
    UIImageView* middleView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                            NavBarHeight + 5,
                                                                            ScreenWidth,
                                                                            MIDDLE_HEIGHT)];
    UIImage* bgImage  = [UIImage imageNamed:RetrivePlist(@"MiddleBg")];
    [middleView setImage:[bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(1,
                                                                               0.5,
                                                                               0.5,
                                                                               1)]];
    
    UIButton *newPostBtn = [NUButton mainPageBtnWithImage:RetrivePlist(@"MiddleBtn1") withRect:CGRectMake(0,
                                                                                                          0,
                                                                                                          ScreenWidth/2.0, MIDDLE_HEIGHT)];
    
    [newPostBtn addTarget:self
                   action:@selector(newPost)
         forControlEvents:UIControlEventTouchUpInside];
    
    [middleView addSubview:newPostBtn];
    
    UIButton *homeMessageBtn = [NUButton mainPageBtnWithImage:RetrivePlist(@"MiddleBtn2") withRect:CGRectMake(ScreenWidth/2.0,
                                                                                                              0,
                                                                                                              ScreenWidth/2.0, MIDDLE_HEIGHT)];
    
    [homeMessageBtn addTarget:self
                       action:@selector(newPost)
             forControlEvents:UIControlEventTouchUpInside];
    
    [middleView addSubview:homeMessageBtn];
    [middleView setUserInteractionEnabled:YES];
    
    [self.scrollView addSubview:middleView];
}

#pragma mark - 按钮区
/*---------------------------------------
 * 按扭区
 *--------------------------------------*/
-(void)setupFunctionArea{

    float margin = (ScreenWidth - MAIN_BUTTON_WIDTH*ROW_ITEMS_COUNT)/2;

    NSInteger totalCount = [RetrivePlist(@"BtnCount") integerValue];

    NSInteger totalRowsCount = ceil(totalCount/ROW_ITEMS_COUNT);

    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              NavBarHeight + 5 + MIDDLE_HEIGHT,
                                                              ScreenWidth,
                                                              MAIN_BUTTON_HEIGHT*totalRowsCount + margin*totalRowsCount + margin)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    int counter = 0;
    BOOL flag = NO;
    
    NSDictionary* dictionary;
    
    //生成按钮区
    for(int j = 0; j < totalRowsCount  && !flag; j++){
        for(int i = 0; i < ROW_ITEMS_COUNT; i++){
            
            counter++;
            if (counter>totalCount) {
                flag = YES;
                break;
            }
            
            CGRect viewRect = CGRectMake(i*MAIN_BUTTON_WIDTH + i*margin,
                                         margin+j*MAIN_BUTTON_HEIGHT + j*margin,
                                         MAIN_BUTTON_WIDTH,
                                         MAIN_BUTTON_HEIGHT);
            
            UIView* functionView = [[UIView alloc] initWithFrame:viewRect];
            [functionView setBackgroundColor:RGB(240, 240, 240)];
            [bgView addSubview:functionView];
            
            NSString* dicIndex = [NSString stringWithFormat:@"%d",counter];
            dictionary = RetrivePlist(dicIndex);
            
            UIButton* funcBtn = [NUButton mainPageDetailBtnWithImage:[dictionary valueForKey:@"icon"]
                                                            withText:[dictionary valueForKey:@"text"]
                                                            withRect:viewRect];
            
            [funcBtn addTarget:self action:@selector(functionTapped:) forControlEvents:
             UIControlEventTouchUpInside];
            [funcBtn setTag:counter];
            [bgView addSubview:funcBtn];
        }
    }
    [self.scrollView addSubview:bgView];
    
    [self.scrollView setBackgroundColor:RGB(240, 240, 240)];
    [self.scrollView setFrame:CGRectMake(0,
                                         0,
                                         ScreenWidth,
                                         ScreenHeight)];
    
    [self.scrollView setContentSize:CGSizeMake(ScreenWidth,
                                               NavBarHeight + 5 + MIDDLE_HEIGHT + ViewHeight(bgView) + 100)];
}

#pragma mark -
- (IIViewDeckController*)generateControllerStackWithCenter:(UIViewController*)center{
    
    NULeftViewController* leftController = [[NULeftViewController alloc] init];
    [leftController setRootViewController:self];
    center = [[UINavigationController alloc] initWithRootViewController:center];
    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:center
                                                                                    leftViewController:leftController
                                                                                   rightViewController:nil];
    deckController.rightSize = 100;
    [deckController disablePanOverViewsOfClass:NSClassFromString(@"_UITableViewHeaderFooterContentView")];
    return deckController;
}

#pragma mark - 功能选择
/*---------------------------------------
 * 选择功能项
 *--------------------------------------*/
-(void)functionTapped:(UIButton*)sender{
    
    NSString*       dicIndex = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSDictionary* dictionary = RetrivePlist(dicIndex);
    NSString* controllerName = [dictionary valueForKey:@"function"];
    
    Class detailController = NSClassFromString(controllerName);
    
    if (detailController) {
        
        id controller = [[detailController alloc] init];
        IIViewDeckController* deckController = [self generateControllerStackWithCenter:controller];
        [self.navigationController pushViewController:deckController animated:YES];
    }
}

#pragma mark -
-(void)newPost{
    
}

#pragma mark - 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

//
//  NUBaseViewController.m
//  NUWebOffice
//
//  Created by JY on 14-4-18.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUBaseViewController.h"


@interface NUBaseViewController ()


@end

@implementation NUBaseViewController

@synthesize notificationInfo = _notificationInfo;
@synthesize progressHUD = _progressHUD;

#pragma mark -  初始化 NIB反序列化
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitial];
    }
    return self;
}

#pragma mark -  初始化 IN CODE
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInitial];
    }
    return self;
}

#pragma mark -
/*---------------------------------------
 * 初始化通知名称 配置文件
 *--------------------------------------*/
-(void)commonInitial{
    
    _notificationInfo = [NSString stringWithFormat:@"__notify__%@__%d",
                         [self class],arc4random()];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",
                                                  [self class]]
                                          ofType:@"plist"];
    
    _configlist = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    //Bussiness
//    if (RetrivePlist(@"Bussiness")) {
//        _bussiness = [[NSClassFromString(RetrivePlist(@"Bussiness")) alloc]
//                      init];
//    }
}

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:RGBA(240, 240, 240, 1)];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.opaque = YES;
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.title = RetrivePlist(@"Title");
}

#pragma mark -  viewWillAppear 注册通知
/*---------------------------------------
 * 注册通知
 *--------------------------------------*/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleResponse:)
                               name:self.notificationInfo
                             object:nil];
}

#pragma mark -  viewWillDisappear 移除通知
/*---------------------------------------
 * 移除通知
 *--------------------------------------*/
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -  回调
/*---------------------------------------
 * 回调
 *--------------------------------------*/
-(void)handleResponse:(NSNotification*)notification{
}

#pragma mark -  添加HUD
/*---------------------------------------
 * 添加HUD
 *--------------------------------------*/
-(void)addProgressHUDWithInfo:(NSString*)infomation{
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [_progressHUD setLabelText:infomation];
    [self.view addSubview:_progressHUD];
    [self.progressHUD show:YES];
}

-(void)removeProgressHUD{
    [self.progressHUD hide:YES];
}

-(void)showNetworkErrorHUD{
    [NUUtility showProgressHUDWithText:NSLocalizedString(@"NETWORK_ERROR", nil)
                                inView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -  显示ALERT
-(void)showAlertViewWithInfo:(NSString*)infomation{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TIP", nil)
                                                        message:infomation
                                                       delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)dealloc{
    [DefaultNotificationCenter removeObserver:self];
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

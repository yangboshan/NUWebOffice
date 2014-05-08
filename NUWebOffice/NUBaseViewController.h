//
//  NUBaseViewController.h
//  NUWebOffice
//
//  Created by JY on 14-4-18.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NUApp-Macro.h"
#import "MBProgressHUD.h"
#import "NUBussiness.h"
#import "NUUtility.h"


#define RetrivePlist(s) (self.configlist) ? [self.configlist valueForKey:s] : nil
@interface NUBaseViewController : UIViewController


@property(nonatomic,strong) NSString* notificationInfo;
@property(nonatomic,strong) MBProgressHUD *progressHUD;
@property(nonatomic,strong) NSDictionary *configlist;
@property(nonatomic,strong) NUBussiness *bussiness;

-(void)showAlertViewWithInfo:(NSString*)infomation;
-(void)addProgressHUDWithInfo:(NSString*)infomation;
-(void)removeProgressHUD;
-(void)showNetworkErrorHUD;
@end

//
//  NULoginViewController.m
//  NUWebOffice
//
//  Created by JY on 14-4-18.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NULoginViewController.h"
#import "NULoginBussiness.h"
#import "NUMainViewController.h"

@interface NULoginViewController ()

@end

@implementation NULoginViewController


- (void)viewDidLoad
{

    [super viewDidLoad];
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView* subView = (UIView*)obj;
        subView.frame = CGRectMake(ScreenWidth/2.0 - ViewWidth(subView)/2.0,
                                        ViewY(subView),
                                        ViewWidth(subView),
                                        ViewHeight(subView));
    }];
    
    [self authenticate:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 认证
- (IBAction)authenticate:(id)sender {

    [self addProgressHUDWithInfo:RetrivePlist(@"ValidateUser")];
    
    
    [[NULoginBussiness sharedNULoginBussiness] setNotificationInfo:self.notificationInfo];
    [[NULoginBussiness sharedNULoginBussiness] authenWithUserName:nil withSKey:nil];
}

#pragma mark - 回调
-(void)handleResponse:(NSNotification*)notification{
    
    [self removeProgressHUD];
    NSDictionary *resultSet = notification.userInfo;
    NSNumber *result = [resultSet valueForKey:NSLocalizedString(@"RESPONSE", nil)];
    
    if ([result integerValue]) {
        
        [self performSegueWithIdentifier:RetrivePlist(@"Segue") sender:self];
        
    } else {
        
        [self showAlertViewWithInfo:RetrivePlist(@"ValidateError")];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:RetrivePlist(@"Segue")]) {
        
    }
}

@end

//
//  NUUtility.m
//  NUWebOffice
//
//  Created by JY on 14-4-18.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUUtility.h"
#import "MBProgressHUD.h"

@implementation NUUtility
 

+(BOOL)isNetworkAvailable{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
 
    if(remoteHostStatus == NotReachable) {
        return NO;
    }
    return YES;
}

+(void)showProgressHUDWithText:(NSString*)text inView:(UIView*)view{
    MBProgressHUD *_progressHUD = [[MBProgressHUD alloc] initWithView:view];
    [_progressHUD setLabelText:text];
    _progressHUD.mode = MBProgressHUDModeText;
    [view addSubview:_progressHUD];
    [view bringSubviewToFront:_progressHUD];
    [_progressHUD show:YES];
    [_progressHUD hide:YES afterDelay:2];
}

@end

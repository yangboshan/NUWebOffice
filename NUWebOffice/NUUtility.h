//
//  NUUtility.h
//  NUWebOffice
//
//  Created by JY on 14-4-18.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"


@interface NUUtility : NSObject
 
+(BOOL)isNetworkAvailable;
+(void)showProgressHUDWithText:(NSString*)text inView:(UIView*)view;
@end

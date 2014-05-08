//
//  NUHTTPSessionManager.h
//  NUWebOffice
//
//  Created by JY on 14-4-24.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "NUGCDSingleton.h"

@interface NUHTTPSessionManager : AFHTTPSessionManager


+(NUHTTPSessionManager*)sharedNUHTTPSessionManager;

@end

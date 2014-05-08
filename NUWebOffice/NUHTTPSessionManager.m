//
//  NUHTTPSessionManager.m
//  NUWebOffice
//
//  Created by JY on 14-4-24.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUHTTPSessionManager.h"

static NSString * const WorldWeatherOnlineURLString = @"http://";

@implementation NUHTTPSessionManager

GCD_SYNTHESIZE_SINGLETON_FOR_CLASS(NUHTTPSessionManager)

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

@end

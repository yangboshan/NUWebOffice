//
//  NULoginPageBussiness.m
//  NUWebOffice
//
//  Created by JY on 14-4-18.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NULoginBussiness.h"
#import "AFNetworking.h"


@interface NULoginBussiness()


@end

@implementation NULoginBussiness

GCD_SYNTHESIZE_SINGLETON_FOR_CLASS(NULoginBussiness)

-(id)init{
    
    if (self = [super init]) {
        
    }
    return self;
}

//验证用户身份信息
-(void)authenWithUserName:(NSString*)userInfo withSKey:(NSString*)skey{
    
    //.......

//    NSString *string = [NSString stringWithFormat:@"%@service.php?format=json", nil];
//    NSURL *url = [NSURL URLWithString:string];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }];
//
//    [operation start];
    
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,
                                            delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        
        [dic setValue:NSNumWithInt(1) forKey:NSLocalizedString(@"RESPONSE", nil)];
        
        [DefaultNotificationCenter postNotificationName:self.notificationInfo
                                          object:nil
                                        userInfo:dic];
        
    });
}

@end

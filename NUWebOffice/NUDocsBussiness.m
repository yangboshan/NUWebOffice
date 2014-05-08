//
//  NUDocumentBussiness.m
//  NUWebOffice
//
//  Created by JY on 14-4-24.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUDocsBussiness.h"
#import "AFNetworking.h"
#import "SPREST.h"

@interface NUDocsBussiness()

@property(nonatomic,strong) NSMutableArray* resultRet;
@end

@implementation NUDocsBussiness

GCD_SYNTHESIZE_SINGLETON_FOR_CLASS(NUDocsBussiness)

-(id)init{
    if (self = [super init]) {
        if (![[SPAuthCookies sharedSPAuthCookie] rtFa] || ![[SPAuthCookies sharedSPAuthCookie] fedAuth]) {
            SPFormsAuth* form_auth = [[SPFormsAuth alloc] initWithUsernamePasswordSite:SPUserName password:SPUserPsw site:SPRestUrl];
            [form_auth authenticate];
        }
    }
    return  self;
}

-(void)getDocslistFromSPSite{
    
//    //获取指定标题列表
//    NSString *urlString = [NSString stringWithFormat:@"%@%@",SPRestUrl,@"_api/Web/lists/getByTitle('Test2014')/Items"];
    
    //获取Shared Documents list
    NSString *urlString = [NSString stringWithFormat:@"%@%@",
                           SPRestUrl,@"_api/Web/GetFolderByServerRelativeUrl('/sites/fba/Shared%20Documents')/Files"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];

    NSArray* cookieArray = [NSArray arrayWithObjects:
                            [[SPAuthCookies sharedSPAuthCookie] rtFa],
                            [[SPAuthCookies sharedSPAuthCookie] fedAuth],
                            nil];
    NSDictionary * cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookieArray];
    NSMutableDictionary * requestHeaders = [[NSMutableDictionary alloc] initWithDictionary:
                                            cookieHeaders];
    [requestHeaders setObject: @"application/json;odata=verbose"
                       forKey: @"Accept"];
    
	[theRequest setHTTPMethod:@"GET"];
    [theRequest setAllHTTPHeaderFields:requestHeaders];
    if (![NUUtility isNetworkAvailable]){
        [theRequest setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
    
    
    
//    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
// 
//    [theRequest setValue: @"application/json;odata=verbose" forHTTPHeaderField: @"Accept"];
//	[theRequest setHTTPMethod:@"GET"];
 
 
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        self.resultRet = [NSMutableArray array];
        NSDictionary* result = [[(NSDictionary*)responseObject objectForKey:@"d"]
                                objectForKey:@"results"];
        for(NSDictionary* dic in result){
            [self.resultRet addObject:[dic valueForKey:@"Name"]];
        }
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        [dic setValue:self.resultRet forKey:NSLocalizedString(@"RESPONSE", nil)];
        [DefaultNotificationCenter postNotificationName:self.notificationInfo
                                                 object:nil
                                               userInfo:dic];
        NSLog(@"已获取文档列表");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    [operation start];
}
@end

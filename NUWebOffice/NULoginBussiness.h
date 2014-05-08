//
//  NULoginPageBussiness.h
//  NUWebOffice
//
//  Created by JY on 14-4-18.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUBussiness.h"


@interface NULoginBussiness : NUBussiness


+(NULoginBussiness*)sharedNULoginBussiness;

-(void)authenWithUserName:(NSString*)userInfo
                       withSKey:(NSString*)skey;
@end

//
//  NULeftSideViewController.h
//  NUWebOffice
//
//  Created by JY on 14-4-22.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NUBaseViewController.h"

@interface NULeftViewController : NUBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIViewController* rootViewController;
@end

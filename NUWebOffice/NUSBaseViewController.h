//
//  NUFunctionBaseViewController.h
//  NUWebOffice
//
//  Created by JY on 14-4-21.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NUBaseViewController.h"
#import "IIViewDeckController.h"
#import "NULeftViewController.h"
#import "NUDropDownList.h"

@interface NUSBaseViewController : NUBaseViewController<NUDropDownListDelegate>

@property (nonatomic,strong) NUDropDownList *dropdownlistView;

-(void)showDropdownlist;
-(void)hideDropdownlist;


@end

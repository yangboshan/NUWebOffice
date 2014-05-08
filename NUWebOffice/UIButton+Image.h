//
//  UIButton+Image.h
//  NUWebOffice
//
//  Created by JY on 14-4-20.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Image)

+(UIButton*)mainPageBtnWithImage:(NSString*)image
                        withRect:(CGRect)rect;

+(UIButton*)mainPageDetailBtnWithImage:(NSString*)image
                              withText:(NSString*)text
                              withRect:(CGRect)rect;

@end

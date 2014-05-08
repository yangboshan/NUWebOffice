////
////  UIButton+Image.m
////  NUWebOffice
////
////  Created by JY on 14-4-20.
////  Copyright (c) 2014年 XLDZ. All rights reserved.
////
//
//#import "UIButton+Image.h"
//#import "NUApp-Macro.h"
//
//@interface UIButton()
//
//
//@end
//
//@implementation UIButton (Image)
//
//-(void)setHighlighted:(BOOL)highlighted{
//    if (highlighted) {
//        self.backgroundColor = RGBA(1, 1, 1, 0.1);
//    } else {
//        self.backgroundColor = [UIColor clearColor];
//    }
//}
//
//+(UIButton*)mainPageBtnWithImage:(NSString*)image withRect:(CGRect)rect{
//    
//    UIImage* btnImage = [UIImage imageNamed:image];
//    UIButton* customBtn = [[UIButton alloc] initWithFrame:rect];
//    
//    [customBtn setFrame:rect];
//    [customBtn setImage:btnImage forState:UIControlStateNormal];
//    
//    return customBtn;
//}
//
//+(UIButton*)mainPageDetailBtnWithImage:(NSString*)image withText:(NSString*)text
//                              withRect:(CGRect)rect{
//    
//    UIButton* funcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [funcBtn setFrame:rect];
//    
//    UIImageView* btnImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
//    [btnImage setFrame:CGRectMake(RectWidth(rect)/2.0 - 15, RectHeight(rect)/2.0 - 20, 30, 28)];
//    UILabel *btnTitle = [[UILabel alloc] initWithFrame:CGRectMake(RectWidth(rect)/2.0 - 20, RectHeight(rect)/2.0 + 20, 50, 20)];
//    [btnTitle setText:text];
//    [btnTitle setTextAlignment:NSTextAlignmentCenter];
//    [btnTitle setFont:[UIFont boldSystemFontOfSize:12.0]];
//    [btnTitle setTextColor:[UIColor lightGrayColor]];
//    
//    [funcBtn addSubview:btnImage];
//    [funcBtn addSubview:btnTitle];
//    
//    return funcBtn;
//}
//
//@end

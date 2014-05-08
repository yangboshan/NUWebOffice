//
//  NUDropDownList.h
//  NUWebOffice
//
//  Created by JY on 14-4-22.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import <UIKit/UIKit.h>

/*---------------------------------------
 * NUDropDownList Protocol
 *--------------------------------------*/
@protocol NUDropDownListDelegate <NSObject>

-(void)dropdownlistDidSelectWithTag:(NSString*)tag;

@end

@interface NUDropDownList : UITableViewController

@property (nonatomic,strong) NSArray* datalist;
@property (nonatomic,weak) id<NUDropDownListDelegate> delegate;


@end

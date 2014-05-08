//
//  UITableViewCell+AutoDequeue.h
//  NUWebOffice
//
//  Created by JY on 14-4-22.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (AutoDequeue)

+ (id)tableViewAutoDequeueCell:(UITableView*)tableView;
+ (void)tableViewRegisterAutoDequeueFromNib:(UITableView*)tableView withIdentifier:(NSString*)identifier;
   
@end

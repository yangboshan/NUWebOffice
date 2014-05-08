//
//  UITableViewCell+AutoDequeue.m
//  NUWebOffice
//
//  Created by JY on 14-4-22.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "UITableViewCell+AutoDequeue.h"

@implementation UITableViewCell (AutoDequeue)

+ (id)tableViewAutoDequeueCell:(UITableView*)tableView {
    NSString *cellIdentifier = NSStringFromClass(self);
    
    id cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [self alloc];
        if ([cell respondsToSelector:@selector(initWithReuseIdentifier:)])
            cell = [cell initWithReuseIdentifier:cellIdentifier];
        else 
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

+ (void)tableViewRegisterAutoDequeueFromNib:(UITableView*)tableView withIdentifier:(NSString*)identifier{
    [tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
}


@end

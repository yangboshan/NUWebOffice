//
//  NUDocumentTableViewCell.h
//  NUWebOffice
//
//  Created by JY on 14-4-23.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoLayout.h"

@interface NUDocsTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *docName;
@property (weak, nonatomic) IBOutlet UILabel *docDesc;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fileIcon;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrow;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIButton *favBtn;

- (IBAction)postComment:(id)sender;
@end

//
//  NUDocumentTableViewCell.m
//  NUWebOffice
//
//  Created by JY on 14-4-23.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUDocsTableViewCell.h"
#import "NUApp-Macro.h"


@implementation NUDocsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [self setBackgroundColor:RGB(240, 240, 240)];
    
    [self.commentBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:44.0f];
    [self.commentBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:13.0f];
    [self.replyBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:142.0f];
    [self.replyBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:13.0f];
    [self.favBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:248.0f];
    [self.favBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:13.0f];
    
    
//    [self.bgImageView setImage:[UIImage imageNamed:@"docPostBackground"]];
//    [self.bgImageView setFrame:CGRectMake(0, 5, 300, 150)];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)postComment:(id)sender {
}
@end

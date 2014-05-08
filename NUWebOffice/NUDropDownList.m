//
//  NUDropDownList.m
//  NUWebOffice
//
//  Created by JY on 14-4-22.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUDropDownList.h"
#import "UITableViewCell+AutoDequeue.h"
#import <QuartzCore/QuartzCore.h>

@interface NUDropDownList ()

@end

#define ROWWIDTH 200.0
#define ROW_HEIGHT 40.0
@implementation NUDropDownList

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.tableView.frame = CGRectMake(0,
                                      0,
                                      ROWWIDTH,
                                      ROW_HEIGHT*[self.datalist count]);
    
    self.tableView.tag = ROW_HEIGHT*[self.datalist count];
    
    self.view.layer.masksToBounds = YES;
    [self.tableView.layer setShadowOffset:CGSizeMake(0.5, 0.5)];
    [self.tableView.layer setShadowOpacity:0.2];
    [self.tableView.layer setShadowRadius:1.0];
    [self.tableView.layer setShadowColor:[UIColor blackColor].CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ROW_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datalist count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell tableViewAutoDequeueCell:tableView];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [[self.datalist objectAtIndex:indexPath.row] valueForKey:@"Text"];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* tag = [[self.datalist objectAtIndex:indexPath.row] valueForKey:@"Tag"];
    [self.delegate dropdownlistDidSelectWithTag:tag];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}
 

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

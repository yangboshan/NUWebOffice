//
//  NUTaskViewController.m
//  NUWebOffice
//
//  Created by JY on 14-4-24.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUTaskViewController.h"

@interface NUTaskViewController ()

@property(nonatomic,strong) UITableView* doclistView;
@property(nonatomic,strong) NSArray *datalist;

@end

@implementation NUTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dropdownlistDidSelectWithTag:(NSString*)tag{
    
    [self showAlertViewWithInfo:[NSString stringWithFormat:@"%@ tapped",tag]];
    [self hideDropdownlist];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.doclistView = [[UITableView alloc] initWithFrame:CGRectMake(10,
                                                                     0,
                                                                     ScreenWidth - 20,
                                                                     ScreenHeight)
                                                    style:UITableViewStylePlain];
    [self.doclistView setDelegate:self];
    [self.doclistView setDataSource:self];
    [self.doclistView setSeparatorColor:[UIColor clearColor]];
    [self.doclistView setBackgroundColor:RGB(240, 240, 240)];
    [self.doclistView setShowsVerticalScrollIndicator:NO];

    [self.view addSubview:self.doclistView];
    
    self.datalist = [NSArray arrayWithObjects:@"test",@"<?xml version=\"1.0\" encoding=\"UTF-8\"?> <soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:q0=\"http://ws.xlny.com/\" xmlns:xsd=\" http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"> <soapenv:Body>",@"test", nil];
}

#pragma mark - Table view data source
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
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
    NSString* identifier = [NSString stringWithFormat:@"%@",[NUDocsTableViewCell class]];
    [UITableViewCell tableViewRegisterAutoDequeueFromNib:tableView withIdentifier:identifier];
    NUDocsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.docName.text = [self.datalist objectAtIndex:indexPath.row];
    
    cell.docDesc.text = @"sharepoint2013 测试上传文档";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

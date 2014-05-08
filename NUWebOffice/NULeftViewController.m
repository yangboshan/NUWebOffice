//
//  NULeftSideViewController.m
//  NUWebOffice
//
//  Created by JY on 14-4-22.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NULeftViewController.h"
#import "UITableViewCell+AutoDequeue.h"
#import "NUSBaseViewController.h"

@interface NULeftViewController ()

@property(nonatomic,strong) UITableView* leftlistView;
@property(nonatomic,strong) NSArray *datalist;
@property(nonatomic,strong) UIView* topbar;
@property(nonatomic,strong) UIView* bottombar;
@end

#define ROW_HEIGHT 40
@implementation NULeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupTopbar];
    [self setupBottombar];
    
    self.leftlistView = [[UITableView alloc] initWithFrame:CGRectMake(5,
                                                                      30 + NavBarHeight,
                                                                      ScreenWidth - 100,
                                                                      ScreenHeight - (30 + NavBarHeight) - ViewHeight(_bottombar)) style:UITableViewStylePlain];
    [self.leftlistView setDelegate:self];
    [self.leftlistView setDataSource:self];
    [self.view addSubview:self.leftlistView];
    self.datalist = RetrivePlist(@"DataList");
}

-(void)setupTopbar{
    
    _topbar = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              20,
                                                              ScreenWidth,
                                                              NavBarHeight + 5)];
    [_topbar setBackgroundColor:[UIColor whiteColor]];
    UIImageView* head = [[UIImageView alloc] initWithImage:
                         [UIImage imageNamed:@"defaultAvatar"]];
    [head setFrame:CGRectMake(5, 5, 40, 40)];
    [_topbar addSubview:head];
    
    UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 50, 30)];
    [name setFont:[UIFont systemFontOfSize:15.0]];
    [name setTextAlignment:NSTextAlignmentCenter];
    [name setText:@"周军"];
    [_topbar addSubview:name];
    
    UIImageView* rightArrow = [[UIImageView alloc] initWithImage:
                               [UIImage imageNamed:@"ma_rightArrow"]];
    
    [rightArrow setFrame:CGRectMake(ScreenWidth - 80,
                                    18,
                                    24,
                                    17)];
    [_topbar addSubview:rightArrow];
    
    _topbar.layer.shadowColor = [[UIColor grayColor] CGColor];
    _topbar.layer.shadowOpacity = 0.2;
    _topbar.layer.shadowRadius = 1.0;
    _topbar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _topbar.layer.shadowPath = [UIBezierPath bezierPathWithRect:_topbar.bounds].CGPath;
    
    [self.view addSubview:_topbar];
}

-(void)setupBottombar{
    _bottombar = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              ScreenHeight - NavBarHeight - 5,
                                                              ScreenWidth,
                                                              NavBarHeight + 10)];
    [_bottombar setBackgroundColor:[UIColor whiteColor]];
    _bottombar.layer.shadowColor = [[UIColor grayColor] CGColor];
    _bottombar.layer.shadowOpacity = 0.2;
    _bottombar.layer.shadowRadius = 1.0;
    _bottombar.layer.shadowOffset = CGSizeMake(-1.0f, -1.0f);
    _bottombar.layer.shadowPath = [UIBezierPath bezierPathWithRect:_topbar.bounds].CGPath;
    [self.view addSubview:_bottombar];
    
    UIButton *retHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [retHomeBtn setFrame:CGRectMake(20, 5, 150, 30)];
    [retHomeBtn addTarget:self action:@selector(retHome) forControlEvents:UIControlEventTouchUpInside];
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 120, 30)];
    [title setText:@"返回主界面"];
    [title setTextColor:[UIColor grayColor]];
    [retHomeBtn addSubview:title];
    
    UIImageView *leftIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12, 24, 17)];
    [leftIndicator setImage:[UIImage imageNamed:@"ma_leftArrow"]];
    [retHomeBtn addSubview:leftIndicator];
    [_bottombar addSubview:retHomeBtn];
}

-(void)retHome{
    [self.navigationController popToViewController:self.rootViewController
                                          animated:YES];
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
    cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = [[self.datalist objectAtIndex:indexPath.row] valueForKey:@"Text"];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* className = [[self.datalist objectAtIndex:indexPath.row] valueForKey:@"Function"];
    Class destClass = NSClassFromString(className);
    NUSBaseViewController* destController = [[destClass alloc] init];
    IIViewDeckController* deckController = [self generateControllerStackWithCenter:destController];
    [self.navigationController pushViewController:deckController animated:YES];

}

- (IIViewDeckController*)generateControllerStackWithCenter:(UIViewController*)center{
    NULeftViewController* leftController = [[NULeftViewController alloc] init];
    [leftController setRootViewController:self.rootViewController];
    center = [[UINavigationController alloc] initWithRootViewController:center];
    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:center
                                                                                    leftViewController:leftController
                                                                                   rightViewController:nil];
    deckController.rightSize = 100;
    [deckController disablePanOverViewsOfClass:NSClassFromString(@"_UITableViewHeaderFooterContentView")];
    return deckController;
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

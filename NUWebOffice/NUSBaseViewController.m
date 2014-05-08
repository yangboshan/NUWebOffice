//
//  NUFunctionBaseViewController.m
//  NUWebOffice
//
//  Created by JY on 14-4-21.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUSBaseViewController.h"

@interface NUSBaseViewController ()

@property (nonatomic,strong) UIImageView* arrowView;
@property (nonatomic,assign) CGRect dRect;

@end

@implementation NUSBaseViewController

#pragma mark -  初始化 添加展开左边栏按钮等
- (id)init{
    
    if (self = [super init]) {
        
        
        /*---------------------------------------
         * 添加展开左边栏按钮
         *--------------------------------------*/
        UIButton *leftBarButton = [[UIButton alloc] init];
        leftBarButton.frame = CGRectMake(5,5,30,22);
        
        [leftBarButton setImage:[UIImage imageNamed: @"menuOnTheLeft"]
                       forState:UIControlStateNormal];
        [leftBarButton setImage:[UIImage imageNamed: @"menuOnTheLeftHightlight"]
                       forState:UIControlStateHighlighted];
        
        [leftBarButton addTarget:self.viewDeckController action:@selector(toggleLeftView)
                forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:
                                                 leftBarButton];

        
        /*---------------------------------------
         * 下拉菜单初始化
         *--------------------------------------*/
        _dropdownlistView = [[NUDropDownList alloc] initWithStyle:UITableViewStylePlain];
        [_dropdownlistView setDatalist:RetrivePlist(@"DropDownList")];
        [_dropdownlistView setDelegate:self];
        _dropdownlistView.view.frame = CGRectMake(ScreenWidth/2.0 - ViewWidth(_dropdownlistView.tableView)/2.0,
                                                  60,
                                                  ViewWidth(_dropdownlistView.tableView),
                                                  0);
    
  
        [self.view addSubview:_dropdownlistView.view];
        
        self.dRect = _dropdownlistView.view.frame;

        
        /*---------------------------------------
         * 为导航栏添加手势
         *--------------------------------------*/
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self                                                                                     action:@selector(navBarTapped:)];
        [tapGesture setNumberOfTouchesRequired:1];
        [self.navigationItem.titleView addGestureRecognizer:tapGesture];
        [self.navigationItem.titleView  setUserInteractionEnabled:YES];
    }
    
    return self;
}

#pragma mark -  viewDidLoad 自定义导航栏标题及图片显示等
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    /*---------------------------------------
     * 自定义导航栏标题及图片显示
     *--------------------------------------*/
    CGSize textSize = [self.title sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0]];
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    UILabel* title = [[UILabel alloc] init];
    [title setText:self.title];
    [title setFont:[UIFont boldSystemFontOfSize:17.0]];
    [title setTextColor:[UIColor darkGrayColor]];
    
    [title setFrame:CGRectMake(ViewWidth(view)/2.0 - textSize.width/2.0,
                               10,
                               textSize.width,
                               textSize.height)];
    
    [title setTextAlignment:NSTextAlignmentJustified];
    [title setBackgroundColor:[UIColor clearColor]];
    [view addSubview:title];
    
    _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(title) + ViewWidth(title) +5,
                                                               13,
                                                               15,
                                                               15)];
    [_arrowView setImage:[UIImage imageNamed:@"arrowDown"]];
    [view addSubview:_arrowView];
    self.navigationItem.titleView = view;
    
}

#pragma mark -  导航栏事件
/*---------------------------------------
 * 导航栏事件
 *--------------------------------------*/
-(void)navBarTapped:(UIGestureRecognizer*)recognizer{
    
    if (self.dropdownlistView.view.frame.size.height == 0) {
        [self showDropdownlist];
    } else {
        [self hideDropdownlist];
    }
}

#pragma mark -  下拉列表动画
/*---------------------------------------
 * 显示下拉列表
 *--------------------------------------*/
-(void)showDropdownlist{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    self.dropdownlistView.view.frame = CGRectMake(_dRect.origin.x,
                                                  _dRect.origin.y,
                                                  _dRect.size.width,
                                                  self.dropdownlistView.tableView.tag);
    
    [self.arrowView setImage:[UIImage imageNamed:@"arrowUp"]];
    [UIView commitAnimations];
}
/*---------------------------------------
 * 隐藏下拉列表
 *--------------------------------------*/
-(void)hideDropdownlist{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.dropdownlistView.view.frame = CGRectMake(_dRect.origin.x,
                                                  _dRect.origin.y,
                                                  _dRect.size.width,
                                                  0);
    [self.arrowView setImage:[UIImage imageNamed:@"arrowDown"]];
    [UIView commitAnimations];
}

#pragma mark -  下拉列表代理 子类覆写
-(void)dropdownlistDidSelectWithTag:(NSString*)tag{
    
    [self showAlertViewWithInfo:[NSString stringWithFormat:@"%@ tapped",tag]];
    [self hideDropdownlist];
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

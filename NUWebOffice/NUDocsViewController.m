//
//  NUDocumentCenterViewController.m
//  NUWebOffice
//
//  Created by JY on 14-4-21.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUDocsViewController.h"
#import "UITableViewCell+AutoDequeue.h"
#import "NUDocsTableViewCell.h"
#import "NUDocsBussiness.h"
#import "NimbusWebController.h"


@interface NUDocsViewController ()

@property(nonatomic,strong) UITableView* doclistView;
@property(nonatomic,strong) NSArray *datalist;
@property(nonatomic,strong) NSMutableArray* searchDatalist;
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UISearchDisplayController *searchController;

@end

@implementation NUDocsViewController

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
    [self buildUI];
    [self requestDocslist];
}

-(void)buildUI{
    
    /*---------------------------------------
     * 搜索栏
     *--------------------------------------*/
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    [_searchBar setPlaceholder:@"搜索"];
    [_searchBar setBarTintColor:RGB(240, 240, 240)];
    _searchBar.layer.borderWidth = 1;
    _searchBar.layer.borderColor = [RGB(240, 240, 240) CGColor];
    [_searchBar setDelegate:self];
    _searchController = [[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    _searchController.active = NO;
    _searchController.searchResultsDataSource = self;
    _searchController.searchResultsDelegate = self;
    
    
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
    self.doclistView.tableHeaderView = _searchBar;
    [self.view addSubview:self.doclistView];
}

#pragma mark - Request
-(void)requestDocslist{
    
    /*---------------------------------------
     * 网络联通则请求文档列表
     *--------------------------------------*/
    if ([NUUtility isNetworkAvailable]) {
        [self addProgressHUDWithInfo:RetrivePlist(@"GetDocslist")];
    } else {
        [self showNetworkErrorHUD];
    }
    
    [[NUDocsBussiness sharedNUDocsBussiness] setNotificationInfo:self.notificationInfo];
    [[NUDocsBussiness sharedNUDocsBussiness] getDocslistFromSPSite];
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchDatalist count];
    } else {
        return [self.datalist count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identifier = [NSString stringWithFormat:@"%@",[NUDocsTableViewCell class]];
    [UITableViewCell tableViewRegisterAutoDequeueFromNib:tableView withIdentifier:identifier];
    NUDocsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        cell.docName.text = [self.searchDatalist objectAtIndex:indexPath.row];
    } else {
        cell.docName.text = [self.datalist objectAtIndex:indexPath.row];
    }
    
    cell.docDesc.text = @"sharepoint2013 测试上传文档";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* docName;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        docName = [self.searchDatalist objectAtIndex:indexPath.row];
    } else {
        docName = [self.datalist objectAtIndex:indexPath.row];
    }
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",SPDocEditUrl,docName,SPAction];
    NIWebController* webController = [[NIWebController alloc] initWithURL:[NSURL URLWithString:url]];
    [self.navigationController pushViewController:webController animated:YES];
}

#pragma mark - Scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self hideDropdownlist];
}

#pragma mark - 回调
-(void)handleResponse:(NSNotification*)notification{
    [self removeProgressHUD];
    NSDictionary *resultSet = notification.userInfo;
    if (resultSet) {
        self.datalist = [resultSet valueForKey:NSLocalizedString(@"RESPONSE", nil)];
        [self.doclistView reloadData];
    }
}


#pragma UISearchDisplayDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([_searchBar.text length]>0) {
        self.searchDatalist = [NSMutableArray array];
        for(NSString* doc in self.datalist){
            NSRange titleResult=[doc rangeOfString:_searchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [self.searchDatalist addObject:doc];
            }
        }
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
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

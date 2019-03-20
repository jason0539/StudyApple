//
//  SAExploreViewController.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/10.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAExploreViewController.h"
#import "SACommonUtil.h"
#import <Masonry/Masonry.h>
#import "SAMovieWebService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "SALoadMoreView.h"
#import "SAMovieCell.h"

NSString * const SAExploreCellIdentifier = @"SAExploreCellIdentifier";

//接口继承另外两个接口，并声明变量
@interface SAExploreViewController () <UITableViewDataSource,UITableViewDelegate>
@property (assign, nonatomic) long currStart;
@property (assign, nonatomic) long total;
@property (strong,nonatomic) NSMutableArray *movieList;
@property (strong,nonatomic) SALoadMoreView *loadMoreView;
@end

@interface SARefreshControl : UIRefreshControl

@end

@implementation SARefreshControl

-(void)beginRefreshing{
    [super beginRefreshing];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)endRefreshing{
    [super endRefreshing];
}

@end

//SAExploreViewController实现
@implementation SAExploreViewController

- (NSMutableArray *)movieList{
    if (!_movieList) {
        _movieList = [NSMutableArray array];
    }
    return _movieList;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
    [self.refreshControl beginRefreshing];
}

-(void)setupUI{
    NSLog(@"setupUI");
    //full screen layout
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    //tableview
    UINib *movieCellNib = [UINib nibWithNibName:@"SAMovieCellNib" bundle:nil];
    [self.tableView registerNib:movieCellNib
         forCellReuseIdentifier:SAExploreCellIdentifier];
//    [self.tableView registerClass:[SAMovieCell class] forCellReuseIdentifier:SAExploreCellIdentifier];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //refreshController
    UIRefreshControl *refresh = [[SARefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    //loadMoreView
    self.loadMoreView = [[SALoadMoreView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
    self.tableView.tableFooterView = self.loadMoreView;
}

#pragma mark -Utility
-(void)requestData:(BOOL)showProgress{
    NSLog(@"requestData");
    
    [self.loadMoreView restartLoadData];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..." ];
    NSDictionary *parameters = @{@"pageLimit":@10,@"start":@(_currStart)};
    [SAMovieWebService requestMovieDataWithParameters:parameters start:^{
        
    } success:^(NSDictionary *result) {
        NSLog(@"获取数据成功");
        if (self.currStart == 0) {
            NSLog(@"刷新或是加载首页，清除数据");
            //self.movieList = [NSMutableArray array];
            [self.movieList removeAllObjects];
        }
        
        [self.movieList addObjectsFromArray:[result objectForKey:@"movieList"]];
        self.total = [[result objectForKey:@"total"] longValue];
        if (self.movieList.count < self.total) {
            NSLog(@"还有下一页数据可以加载");
            [self.loadMoreView restartLoadData];
        }else{
            NSLog(@"已经没有数据可以加载");
            [self.loadMoreView noMoreData];
        }
        
        
        [self.tableView reloadData];
        [self.loadMoreView stopAnimation];
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新" ];
    } failure:^(NSError *error) {
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新" ];
    }];
}

-(void)refresh{
    NSLog(@"refresh");
    _currStart = 0;
    [self requestData:false];
}

-(void)loadMore{
    NSLog(@"loadMore");
    _currStart = _movieList.count;
    [self requestData:false];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection %d",self.movieList.count);
    return self.movieList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cellForRowAtIndexPath %@",indexPath);
    if (indexPath.row >= self.movieList.count) {
        return nil;
    }
    
    SAMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:SAExploreCellIdentifier forIndexPath:indexPath];
    
    SAMovie *movie = [self.movieList objectAtIndex:indexPath.row];
    
    [cell config:movie];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    /*self.refreshControl.isRefreshing == NO加这个条件是为了防止下面的情况发生：
     每次进入UITableView，表格都会沉降一段距离，这个时候就会导致currentOffsetY + scrollView.frame.size.height   > scrollView.contentSize.height 被触发，从而触发loadMore方法，而不会触发refresh方法。
     */
    if ( currentOffsetY + scrollView.frame.size.height  > scrollView.contentSize.height
        &&  self.refreshControl.isRefreshing == NO  && self.loadMoreView.isAnimating == NO && self.loadMoreView.tipsLabel.isHidden ){
        NSLog(@"到达底部，加载更多");
        [self.loadMoreView startAnimation];//开始旋转菊花
        [self loadMore];
    }
}

@end

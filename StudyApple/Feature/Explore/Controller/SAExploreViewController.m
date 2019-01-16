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

NSString * const SAExploreCellIdentifier = @"SAExploreCellIdentifier";

//接口继承另外两个接口，并声明变量
@interface SAExploreViewController () <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSMutableArray *movieList;
@end

//SAExploreViewController实现
@implementation SAExploreViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
    [self requestData];
}

-(void)setupUI{
    NSLog(@"setupUI");
    //full screen layout
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    //tableview
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SAExploreCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //refreshController
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新" ];
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}

#pragma mark -Utility
-(void)requestData{
    NSLog(@"requestData");
    NSDictionary *parameters = @{@"pageLimit":@30,@"pageNum":@1};
    [SAMovieWebService requestMovieDataWithParameters:parameters start:^{
        [SVProgressHUD show];
    } success:^(NSDictionary *result) {
        self.movieList = [result objectForKey:@"movieList"];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)refresh{
    
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

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"Movies";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection");
    return self.movieList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cellForRowAtIndexPath");
    if (indexPath.row >= self.movieList.count) {
        return nil;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SAExploreCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SAExploreCellIdentifier];
    }
    
    SAMovie *movie = [self.movieList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",movie.name,movie.year];
    cell.detailTextLabel.text = movie.genres;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:movie.thumbnailImageURLString] placeholderImage:[SACommonUtil imageWithColor:[UIColor grayColor] size:CGSizeMake(27, 40)] completed:nil];
    cell.layer.shouldRasterize =  YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return cell;
}

@end

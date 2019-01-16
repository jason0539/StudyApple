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
@property (strong,nonatomic) UITableView *myTableView;
@property (strong,nonatomic) NSMutableArray *movieList;
@end

@implementation SAExploreViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
    [self requestData];
}

-(void)setupUI{
    //full screen layout
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    //mytableview
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -Utility
-(void)requestData{
    NSDictionary *parameters = @{@"pageLimit":@30,@"pageNum":@1};
    [SAMovieWebService requestMovieDataWithParameters:parameters start:^{
        [SVProgressHUD show];
    } success:^(NSDictionary *result) {
        self.movieList = [result objectForKey:@"movieList"];
        [self.myTableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - Property
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SAExploreCellIdentifier];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"Movies";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movieList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

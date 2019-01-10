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

NSString * const SAExploreCellIdentifier = @"SAExploreCellIdentifier";

//接口继承另外两个接口，并声明变量
@interface SAExploreViewController () <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView *myTableView;
@end

@implementation SAExploreViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
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
    return 44;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"Header";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SAExploreCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"Hi";
    cell.imageView.image = [SACommonUtil imageWithColor:[UIColor redColor] size:CGSizeMake(30, 30)];
    cell.layer.shouldRasterize =  YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return cell;
}

@end

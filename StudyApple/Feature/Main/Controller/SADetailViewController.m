//
//  SADetailViewController.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/10.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SADetailViewController.h"

@implementation SADetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupUI];
}

-(void)setupUI{
    // Use full screen layout.
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Title.
    self.title = @"Detail";
}

@end

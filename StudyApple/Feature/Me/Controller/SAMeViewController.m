//
//  SAMeViewController.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/10.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAMeViewController.h"
#import <Masonry/Masonry.h>

@implementation SAMeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //Setup
    [self setupUI];
}

- (void)setupUI{
    //define button
    UIButton *helloButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [helloButton setTitle:@"Me Page Content" forState:UIControlStateNormal];
    
    //add button to view
    [self.view addSubview:helloButton];
    
    [helloButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@160.0);
        make.height.equalTo(@40.0);
        make.center.equalTo(self.view);
    }];
}

@end

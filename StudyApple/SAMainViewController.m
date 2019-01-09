//
//  ViewController.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/9.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import "SAMainViewController.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface SAMainViewController ()

@end

@implementation SAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Setup
    [self setupUI];
}

- (void)setupUI{
    //define button
    UIButton *helloButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [helloButton setTitle:@"Hello" forState:UIControlStateNormal];
    [helloButton addTarget:self action:@selector(onHelloButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //add button to view
    [self.view addSubview:helloButton];
    
    [helloButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@60.0);
        make.height.equalTo(@40.0);
        make.center.equalTo(self.view);
    }];
}

-(void) onHelloButtonClicked:(id)sender{
    NSLog(@"Hello,Word!");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Hello" message:@"Hello,World" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancle");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK");
    }];
    [alertController addAction:cancleAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end

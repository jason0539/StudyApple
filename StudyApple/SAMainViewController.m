//
//  ViewController.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/9.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import "SAMainViewController.h"

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
    
    //size
    helloButton.translatesAutoresizingMaskIntoConstraints = NO; // If you want to use Auto Layout to dynamically calculate the size and position of your view, you must set this property to NO.
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:helloButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.0],
                                [NSLayoutConstraint constraintWithItem:helloButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0],
                                [NSLayoutConstraint constraintWithItem:helloButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
                                [NSLayoutConstraint constraintWithItem:helloButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]
                                ]];
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

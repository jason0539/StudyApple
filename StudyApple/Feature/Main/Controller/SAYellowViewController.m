//
//  SADetailViewController.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/10.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAYellowViewController.h"

@implementation SAYellowViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupUI];
}

-(void)setupUI{
    // Title.
    self.title = @"Detail";
}

- (IBAction)yellowButtonPressed:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Yellow View Button Pressed" message:@"You pressed the button on Yellow VC" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yep,I did" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end

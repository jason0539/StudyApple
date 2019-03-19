//
//  SABlueViewController.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/3/19.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import "SABlueViewController.h"
#import "SATabBarViewController.h"

@interface SABlueViewController ()

@end

@implementation SABlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"SABlueViewController viewDidLoad");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)blueButtonPressed:(UIButton *)sender {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Blue View Button Pressed" message:@"You pressed the button on Blue VC" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yep,I did" style:UIAlertActionStyleDefault handler:nil];
//    [alert addAction:action];
//    [self presentViewController:alert animated:YES completion:nil];
    SATabBarViewController *tabBarVc = [[UIStoryboard storyboardWithName:@"TabBar" bundle:nil] instantiateInitialViewController];
    tabBarVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tabBarVc animated:YES];
}

@end

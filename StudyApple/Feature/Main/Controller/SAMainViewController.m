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
#import "SAYellowViewController.h"
#import "SABlueViewController.h"

@interface SAMainViewController ()
@property (strong,nonatomic) SAYellowViewController *yellowVC;
@property (strong,nonatomic) SABlueViewController *blueVC;
@end

@implementation SAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"SAMainViewController viewDidLoad");
    self.blueVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
    self.blueVC.view.frame = self.view.frame;
    [self switchViewFromViewController:nil toViewController:self.blueVC];
}

-(IBAction)switchViews:(id)sender{
    //视情况创建vc
    if (!self.yellowVC.view.superview) {
        if (!self.yellowVC) {
            self.yellowVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Yellow"];
        }
    }else{
        if (!self.blueVC) {
            self.blueVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
        }
    }
    
    //切换
    if (!self.yellowVC.view.superview) {
        self.yellowVC.view.frame = self.view.frame;
        [self switchViewFromViewController:self.blueVC toViewController:self.yellowVC];
    }else{
        self.blueVC.view.frame = self.view.frame;
        [self switchViewFromViewController:self.yellowVC toViewController:self.blueVC];
    }
}

-(void)switchViewFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (fromVC != nil) {
        [fromVC willMoveToParentViewController:nil];
        [fromVC.view removeFromSuperview];
        [fromVC removeFromParentViewController];
    }
    if (toVC != nil) {
        [self addChildViewController:toVC];
        [self.view insertSubview:toVC.view atIndex:0];
        [toVC didMoveToParentViewController:self];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if (!self.yellowVC.view.superview) {
        self.yellowVC = nil;
    }else{
        self.blueVC = nil;
    }
}

@end

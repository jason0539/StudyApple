//
//  AppDelegate.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/9.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import "SAAppDelegate.h"
#import "SAMainViewController.h"
#import "SACommonUtil.h"

@interface SAAppDelegate ()

@end

@implementation SAAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Init root view controller of the application
//    SAMainViewController *vc = [[SAMainViewController alloc] init];
//    self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = vc;
//    [self.window makeKeyAndVisible];

    UIImage *tabImage = nil;
    UIImage *tabImageHighlight = nil;
    
    //Main
    SAMainViewController *mainVC = [[SAMainViewController alloc] init];
    mainVC.title = @"Main";
    tabImage = [[SACommonUtil imageWithColor:[UIColor redColor] size:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tabImageHighlight = [[SACommonUtil imageWithColor:[UIColor grayColor] size:CGSizeMake(30,30)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    mainVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:mainVC.title image:tabImage selectedImage:tabImageHighlight];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    //Explore
    SAMainViewController *exploreVC = [[SAMainViewController alloc] init];
    exploreVC.title = @"Explore";
    tabImage = [[SACommonUtil imageWithColor:[UIColor greenColor] size:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tabImageHighlight = [[SACommonUtil imageWithColor:[UIColor grayColor] size:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    exploreVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:exploreVC.title image:tabImage selectedImage:tabImageHighlight];
    UINavigationController *exploreNavigationController = [[UINavigationController alloc] initWithRootViewController:exploreVC];
    
    //Me
    SAMainViewController *meVC = [[SAMainViewController alloc] init];
    meVC.title = @"Me";
    tabImage = [[SACommonUtil imageWithColor:[UIColor blueColor] size:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tabImageHighlight = [[SACommonUtil imageWithColor:[UIColor grayColor] size:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    meVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:meVC.title image:tabImage selectedImage:tabImageHighlight];
    UINavigationController *meNavigationController = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    //TAB bar controller
    UITabBarController *mainTabBarController = [[UITabBarController alloc] init];
    mainTabBarController.viewControllers = @[mainNavigationController,exploreNavigationController,meNavigationController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = mainTabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

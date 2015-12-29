//
//  AppDelegate.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/27/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "AppDelegate.h"
#import "QMQHotNewsViewController.h"
#import "QMQColumnViewController.h"
#import "QMQLatestNewsViewController.h"
#import "QMQOldNewsViewController.h"
#import "QMQThemesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"icomoon" size:20.0f],
                                                        NSForegroundColorAttributeName : [UIColor redColor]
                                                        } forState:UIControlStateNormal];
    
    QMQHotNewsViewController *hotNewsVC = [[QMQHotNewsViewController alloc] init];
    UINavigationController *hotNewsNAV = [[UINavigationController alloc] initWithRootViewController:hotNewsVC];
//    hotNewsNAV.tabBarItem.title = @"ssss";
    hotNewsNAV.tabBarItem.title = @"\U0000e9a9";
    
    QMQLatestNewsViewController *latestVC = [[QMQLatestNewsViewController alloc] init];
    UINavigationController *latestNAV = [[UINavigationController alloc] initWithRootViewController:latestVC];
//    [latestNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"normal" size:20.0f]}
//                                         forState:UIControlStateNormal];
//    latestNAV.tabBarItem.title = @"\U0000e9a9";

    
    QMQColumnViewController *columnVC = [[QMQColumnViewController alloc] init];
    UINavigationController *columnNAV = [[UINavigationController alloc] initWithRootViewController:columnVC];
//    [columnNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"normal" size:20.0f]}
//                                         forState:UIControlStateNormal];
//    columnNAV.tabBarItem.title = @"\U0000e9a9";

    
    QMQThemesViewController *themesVC = [[QMQThemesViewController alloc] init];
    UINavigationController *themesNAV = [[UINavigationController alloc] initWithRootViewController:themesVC];
//    [themesNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"normal" size:20.0f]}
//                                         forState:UIControlStateNormal];
//    themesNAV.tabBarItem.title = @"\U0000e9a9";

    
    QMQOldNewsViewController *oldNewsVC = [[QMQOldNewsViewController alloc] init];
    UINavigationController *oldNewsNAV = [[UINavigationController alloc] initWithRootViewController:oldNewsVC];
//    [oldNewsNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"normal" size:20.0f]}
//                                         forState:UIControlStateNormal];
//    oldNewsNAV.tabBarItem.title = @"\U0000e9a9";
    
    tabBarController.viewControllers = @[hotNewsNAV, latestNAV, columnNAV, themesNAV, oldNewsNAV];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

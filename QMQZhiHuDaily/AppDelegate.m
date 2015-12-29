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
#import "QMQHistoryNewsViewController.h"
#import "QMQThemesViewController.h"
#import "QMQUIImageUtils.h"

@interface AppDelegate ()

@end

#define COLOR_HOT_NEWS     HexRGBA(221, 67, 72, 255)
#define COLOR_LATEST_NEWS  HexRGBA(147, 200, 103, 255)
#define COLOR_COLUMN       HexRGBA(0, 175, 202, 255)
#define COLOR_THEMES       HexRGBA(252, 210, 10, 255)
#define COLOR_HISTORY_NEWS HexRGBA(210, 143, 91, 255)

static CGFloat const kTabBarImageSize = 25.0f;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBarController;

    QMQHotNewsViewController *hotNewsVC = [[QMQHotNewsViewController alloc] init];
    UINavigationController *hotNewsNAV = [[UINavigationController alloc] initWithRootViewController:hotNewsVC];
    hotNewsNAV.tabBarItem.image = [iconWithInfo(@"\U0000e9a9", COLOR_HOT_NEWS, ICON_FONT_ICOMOON, kTabBarImageSize) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    hotNewsNAV.tabBarItem.title = @"热门新闻";

    QMQLatestNewsViewController *latestVC = [[QMQLatestNewsViewController alloc] init];
    UINavigationController *latestNAV = [[UINavigationController alloc] initWithRootViewController:latestVC];
    latestNAV.tabBarItem.image = [iconWithInfo(@"\U0000e91d", COLOR_LATEST_NEWS, ICON_FONT_ICOMOON, kTabBarImageSize) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    latestNAV.tabBarItem.title = @"最新新闻";

    
    QMQColumnViewController *columnVC = [[QMQColumnViewController alloc] init];
    UINavigationController *columnNAV = [[UINavigationController alloc] initWithRootViewController:columnVC];
    columnNAV.tabBarItem.image = [iconWithInfo(@"\U0000e92e", COLOR_COLUMN, ICON_FONT_ICOMOON, kTabBarImageSize)imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    columnNAV.tabBarItem.title = @"专栏文章";
    
    QMQThemesViewController *themesVC = [[QMQThemesViewController alloc] init];
    UINavigationController *themesNAV = [[UINavigationController alloc] initWithRootViewController:themesVC];
    themesNAV.tabBarItem.image = [iconWithInfo(@"\U0000e920", COLOR_THEMES, ICON_FONT_ICOMOON, kTabBarImageSize) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    themesNAV.tabBarItem.title = @"主题文章";
    
    QMQHistoryNewsViewController *historyNewsVC = [[QMQHistoryNewsViewController alloc] init];
    UINavigationController *historyNewsNAV = [[UINavigationController alloc] initWithRootViewController:historyNewsVC];
    historyNewsNAV.tabBarItem.image = [iconWithInfo(@"\U0000e94e", COLOR_HISTORY_NEWS, ICON_FONT_ICOMOON, kTabBarImageSize) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    historyNewsNAV.tabBarItem.title = @"历史新闻";
    
    tabBarController.viewControllers = @[hotNewsNAV, latestNAV, columnNAV, themesNAV, historyNewsNAV];
    
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

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
#import "QMQThemeViewController.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Start color console
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:COLOR_DDLogInfo
                                     backgroundColor:nil
                                             forFlag:DDLogFlagInfo];
    [[DDTTYLogger sharedInstance] setForegroundColor:COLOR_DDLogVerbose
                                     backgroundColor:nil
                                             forFlag:DDLogFlagVerbose];
    [[DDTTYLogger sharedInstance] setForegroundColor:COLOR_DDLogDebug
                                     backgroundColor:nil
                                             forFlag:DDLogFlagDebug];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 全局导航栏白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate           = self;
    tabBarController.tabBar.translucent = YES;
    self.window.rootViewController      = tabBarController;
    
    UIColor *styleColor = [UIColor colorWithHexString:QMQStyleColor];
    
    QMQHotNewsViewController *hotNewsVC    = [[QMQHotNewsViewController alloc] init];
    UINavigationController   *hotNewsNAV   = [[UINavigationController alloc] initWithRootViewController:hotNewsVC];
    UIImage                  *hotNewsImage = [UIImageUtil imageWithIconFontCode:QMQIconHotNews
                                                                          color:styleColor
                                                                       fontSize:QMQTabarIconSize];
    hotNewsNAV.tabBarItem.image = [hotNewsImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hotNewsNAV.tabBarItem.title = @"热门文章";
    
    QMQLatestNewsViewController *latestVC        = [[QMQLatestNewsViewController alloc] init];
    UINavigationController      *latestNAV       = [[UINavigationController alloc] initWithRootViewController:latestVC];
    UIImage                     *latestNewsImage = [UIImageUtil imageWithIconFontCode:QMQIconLatestNews
                                                                                color:styleColor
                                                                             fontSize:QMQTabarIconSize];
    latestNAV.tabBarItem.image = [latestNewsImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    latestNAV.tabBarItem.title = @"最新文章";
    
    
    QMQColumnViewController *columnVC        = [[QMQColumnViewController alloc] init];
    UINavigationController  *columnNAV       = [[UINavigationController alloc] initWithRootViewController:columnVC];
    UIImage                 *columnNewsImage = [UIImageUtil imageWithIconFontCode:QMQIconColumn
                                                                            color:styleColor
                                                                         fontSize:QMQTabarIconSize];
    columnNAV.tabBarItem.image = [columnNewsImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    columnNAV.tabBarItem.title = @"专栏文章";
    
    QMQThemeViewController *themesVC       = [[QMQThemeViewController alloc] init];
    UINavigationController *themesNAV      = [[UINavigationController alloc] initWithRootViewController:themesVC];
    UIImage                *themeNewsImage = [UIImageUtil imageWithIconFontCode:QMQIconTheme
                                                                          color:styleColor
                                                                       fontSize:QMQTabarIconSize];
    themesNAV.tabBarItem.image = [themeNewsImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    themesNAV.tabBarItem.title = @"主题文章";
    
    QMQHistoryNewsViewController *historyNewsVC    = [[QMQHistoryNewsViewController alloc] init];
    UINavigationController       *historyNewsNAV   = [[UINavigationController alloc] initWithRootViewController:historyNewsVC];
    UIImage                      *historyNewsImage = [UIImageUtil imageWithIconFontCode:QMQIconHistory
                                                                                  color:styleColor
                                                                               fontSize:QMQTabarIconSize];
    historyNewsNAV.tabBarItem.image = [historyNewsImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    historyNewsNAV.tabBarItem.title = @"历史文章";
    
    [[UITabBar appearance] setTintColor:styleColor];
    
    tabBarController.viewControllers = @[hotNewsNAV, latestNAV, columnNAV, themesNAV, historyNewsNAV];
    tabBarController.selectedIndex   = 0;
    
    [Fabric with:@[[Crashlytics class], [Answers class]]];
    return YES;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    CATransition *transition = [CATransition animation];
    transition.duration       = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type           = kCATransitionFade;
    transition.subtype        = kCATransitionFromRight;
    [tabBarController.view.layer addAnimation:transition forKey:@"reveal"];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [TencentOAuth HandleOpenURL:url];
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

//
//  QMQOldNewsViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/27/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHistoryNewsViewController.h"

@interface QMQHistoryNewsViewController ()

@end

@implementation QMQHistoryNewsViewController

#pragma mark - UIViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = @"历史新闻";
    
    UIImage *normalImage = icomoonImage(kIFNavEditDate, hexString(kIFTabbarHistoryColor), kIFNavEditDateSize);
    UIImage *disableImage = icomoonImage(kIFNavEditDate, [UIColor grayColor], kIFNavEditDateSize);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:createNormalImageButton(normalImage, disableImage, self, @selector(tapSelect))];
}

- (void)tapSelect {
    
}

#pragma mark - Data

/// 获取历史数据
- (void)loadYesterdayData {
    
}

#pragma mark - 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

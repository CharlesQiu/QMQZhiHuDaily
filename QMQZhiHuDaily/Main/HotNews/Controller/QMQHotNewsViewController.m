//
//  QMQHotNewsViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/27/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHotNewsViewController.h"
#import "QMQUIImageUtils.h"
#import "UIImageView+AFNetworking.h"
#import "QMQHotNewsListModel.h"

@interface QMQHotNewsViewController ()

@end

@implementation QMQHotNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"热门新闻";
    
    
    [self loadDatas];
}

- (void)loadDatas {
    [QMQHttpService getWithUrl:API_HOT_NEWS param:nil responseBlock:^(QMQHttpBaseResponse *response) {
        if (!response.success) {
            return;
        }
        QMQHotNewsListModel *listModel = [[QMQHotNewsListModel alloc] initWithDic:response.originalDict];
        
        [listModel.recentArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            QMQHotNewsModel *newsModel = obj;
            DDLogError(@"%li", newsModel.newsId);
        }];
    }];
}

- (void)tapButton:sender {
    
}

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

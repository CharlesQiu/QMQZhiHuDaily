//
//  QMQHotNewsViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/27/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHotNewsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "QMQHotNewsListModel.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"

@interface QMQHotNewsViewController ()<UIScrollViewDelegate>


@end

@implementation QMQHotNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = @"热门新闻";
    
    //有基本四种样式
    //    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;//设置样式
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    //        //发送请求
    //        NSLog(@"发送上部分的请求");
    //        //发送信号
    //        [subscriber sendNext:@"上部分数据"];
    //        //发送完毕
    //        //加上后就可以上部分发送完毕后发送下半部分信号
    ////        [subscriber sendCompleted];
    //        return nil;
    //    }];
    //
    //    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    //        //发送请求
    //        NSLog(@"发送下部分的请求");
    //        //发送信号
    //        [subscriber sendNext:@"下部分数据"];
    //        return nil;
    //    }];
    //
    //    [[signalA zipWith:signalB] subscribeNext:^(id x) {
    //        NSLog(@"%@", x);
    //    }];
    
    //    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
    //        [subscriber sendNext:@"A"];
    //        return nil;
    //    }];
    //    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
    //        [subscriber sendNext:@"B"];
    //        return nil;
    //    }];
    //    //把两个信号组合成一个信号
    //    RACSignal *combineSignal = [signalA combineLatestWith:signalB];
    //    //订阅组合信号
    //    [combineSignal subscribeNext:^(id x) {
    //        NSLog(@"%@", x);
    //    }];
    //    [self loadDatas];
}

- (void)loadDatas {
    [QMQHttpService getWithUrl:API_HOT_NEWS param:nil responseBlock:^(QMQHttpBaseResponse *response) {
        if (!response.success) {
            return;
        }
        QMQHotNewsListModel *listModel = [[QMQHotNewsListModel alloc] initWithDic:response.originalDict];
        
        [listModel.recentArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            QMQHotNewsModel *newsModel = obj;
            DDLogError(@"%li", newsModel.newsId);
        }];
    }];
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

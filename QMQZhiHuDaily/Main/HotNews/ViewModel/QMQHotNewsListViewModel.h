//
//  QMQHotNewsListViewModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 1/7/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQRacBaseViewModel.h"

@interface QMQHotNewsListViewModel : QMQRacBaseViewModel

/// 加载数据
@property(nonatomic, readonly, strong) RACCommand *loadCommand;
/// 新闻model数组
@property(nonatomic, readonly, copy) NSArray *modelArray;

@end

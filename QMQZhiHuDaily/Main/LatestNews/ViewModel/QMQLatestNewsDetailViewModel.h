//
//  QMQLatesNewsDetailViewModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 3/12/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QMQLatestNewsDetailModel;

@interface QMQLatestNewsDetailViewModel : NSObject

/// 请求数据
@property (nonatomic, readonly, strong) RACCommand *requestCommand;
/// 新闻详情model
@property (nonatomic, readonly, strong) QMQLatestNewsDetailModel *model;

@end

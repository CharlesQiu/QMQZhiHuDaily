//
//  QMQLatestNewsViewModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQLatestNewsViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

/// 请求命令
@property(nonatomic, readonly, strong) RACCommand *requestCommand;
/// 模型数组
@property(nonatomic, strong) NSArray *modelArray;
/// 点击的cell的新闻id
@property(nonatomic, readonly, assign) NSUInteger tapCellNewsId;

@end

//
//  QMQHistoryNewsListModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 3/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQHistoryNewsListModel : NSObject

@property (nonatomic, readonly, copy) NSArray *modelArray;

- (QMQHistoryNewsListModel *)initWithDic:(NSDictionary *)dic;

@end

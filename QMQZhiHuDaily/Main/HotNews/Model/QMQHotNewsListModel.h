//
//  QMQHotNewsListModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 1/7/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QMQHotNewsModel.h"

@interface QMQHotNewsListModel : NSObject

@property(nonatomic, readonly, copy) NSArray *recentArray;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

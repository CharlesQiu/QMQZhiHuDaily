//
//  QMQColumnListModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 3/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQColumnListModel : NSObject

@property (nonatomic, readonly, copy) NSArray *modelArray;

- (QMQColumnListModel *)initWithDic:(NSDictionary *)dic;

@end

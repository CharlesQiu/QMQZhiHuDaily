//
//  QMQHttpBaseResponse.h
//  QMQZhiHuDaily
//
//  Created by Charles on 12/29/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQHttpBaseResponse : NSObject

@property (nonatomic, readonly, assign) BOOL         success;
@property (nonatomic, readonly, copy  ) NSString     *message;
/// 原始数据
@property (nonatomic, readonly, copy  ) NSDictionary *originalDict;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

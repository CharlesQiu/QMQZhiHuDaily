//
//  QMQHttpBaseResponse.h
//  QMQZhiHuDaily
//
//  Created by Charles on 12/29/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQHttpBaseResponse : NSObject

@property (nonatomic, assign) BOOL      success;
@property (nonatomic, assign) NSInteger statusCode;
/// 原始数据
@property (nonatomic, readonly, copy) NSDictionary *originalDict;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

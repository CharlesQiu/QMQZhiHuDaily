//
//  QMQColumnModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/28/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQColumnModel : NSObject

/// 专栏ID
@property(nonatomic, readonly, assign) NSUInteger columnId;
/// 专栏name
@property(nonatomic, readonly, copy) NSString *name;
/// 专栏图片
@property(nonatomic, readonly, copy) NSString *thumbnail;
/// 专栏描述
@property(nonatomic, readonly, copy) NSString *columnDescription;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

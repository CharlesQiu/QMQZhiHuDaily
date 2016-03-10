//
//  QMQLatestNewsModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQLatestNewsModel : NSObject

/// 新闻ID
@property(nonatomic, readonly, assign) NSUInteger newsId;
/// 新闻标题
@property(nonatomic, readonly, strong) NSString  *title;
/// 新闻图片
@property(nonatomic, readonly, strong) NSString  *imageUrl;

/// 处理数据
- (instancetype)initWithDic:(NSDictionary *)dic;

@end

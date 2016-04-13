//
//  QMQLatestNewsDetailModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/26/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQLatestNewsDetailModel : NSObject

/// 题图
@property (nonatomic, readonly, copy) NSString *imageUrl;
/// 图片来源
@property (nonatomic, readonly, copy) NSString *imageSource;
/// 内容
@property (nonatomic, readonly, copy) NSString *body;
/// 标题
@property (nonatomic, readonly, copy) NSString *title;
/// css
@property (nonatomic, readonly, copy) NSString *css;
/// 分享链接
@property (nonatomic, readonly, copy) NSString *shareUrl;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end

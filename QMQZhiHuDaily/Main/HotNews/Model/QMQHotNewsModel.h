//
//  QMQHotNewsModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 1/7/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQHotNewsModel : NSObject

@property(nonatomic, readonly, assign) NSInteger newsId;
/// 文章配图URL
@property(nonatomic, readonly, copy) NSString *thumbNail;
@property(nonatomic, readonly, copy) NSString *title;
/// 文章详细URL
@property(nonatomic, readonly, copy) NSString *url;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

//
//  QMQHistoryNewsModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/29/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQHistoryNewsModel : NSObject

/// 图片数组
@property(nonatomic, readonly, copy) NSArray *imageArr;
/// 新闻ID
@property(nonatomic, readonly, assign) NSUInteger newsId;
/// 新闻标题
@property(nonatomic, readonly, copy) NSString *title;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

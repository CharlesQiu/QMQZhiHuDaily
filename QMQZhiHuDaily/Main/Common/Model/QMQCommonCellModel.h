//
//  QMQCommonCellModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQCommonCellModel : NSObject

/// 图片数组
@property(nonatomic, readonly, copy) NSArray *imageArr;
/// 新闻ID
@property(nonatomic, readonly, assign) NSUInteger newsId;
/// 新闻标题
@property(nonatomic, readonly, copy) NSString *title;
/// 展示时间(只有专栏列表有)
@property (nonatomic, readonly, copy) NSString *date;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

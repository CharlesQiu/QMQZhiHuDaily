//
//  QMQThemeModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/28/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQThemeModel : NSObject

/// 主题ID
@property(nonatomic, readonly, assign) NSUInteger themeId;
/// 主题name
@property(nonatomic, readonly, copy) NSString *name;
/// 主题图片
@property(nonatomic, readonly, copy) NSString *thumbnail;
/// 主题描述
@property(nonatomic, readonly, copy) NSString *themeDescription;
/// 颜色
@property(nonatomic, readonly, copy) NSString *color;

- (QMQThemeModel *)initWithDic:(NSDictionary *)dic;
@end

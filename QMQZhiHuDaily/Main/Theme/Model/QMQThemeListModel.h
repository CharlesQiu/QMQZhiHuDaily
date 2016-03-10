//
//  QMQThemeListModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 3/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQThemeListModel : NSObject

@property (nonatomic, readonly, copy) NSArray *modelArray;

- (QMQThemeListModel *)initWithDic:(NSDictionary *)dic;

@end

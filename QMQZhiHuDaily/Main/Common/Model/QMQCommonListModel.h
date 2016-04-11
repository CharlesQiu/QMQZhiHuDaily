//
//  QMQCommonListModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQCommonListModel : NSObject

@property (nonatomic, readonly, copy) NSString *timeStamp;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSArray  *modelArray;

- (QMQCommonListModel *)initWithDic:(NSDictionary *)dic;

@end

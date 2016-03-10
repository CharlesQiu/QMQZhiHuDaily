//
//  QMQLatestNewsDetailModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/26/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQLatestNewsDetailModel : NSObject

@property(nonatomic, readonly, copy) NSString *imageUrl;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

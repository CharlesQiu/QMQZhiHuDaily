//
//  QMQLatestNewsModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQLatestNewsModel : NSObject

@property(nonatomic, readonly, assign) NSInteger newsId;
@property(nonatomic, readonly, strong) NSString  *title;
@property(nonatomic, readonly, strong) NSString  *imageUrl;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

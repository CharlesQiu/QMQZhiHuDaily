//
//  QMQAccountInfo.h
//  QMQZhiHuDaily
//
//  Created by Charles on 4/12/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQAccountInfo : NSObject<NSCoding>

@property (nonatomic, readonly, copy) NSString *city;
@property (nonatomic, readonly, copy) NSString *province;
@property (nonatomic, readonly, copy) NSString *nickName;
@property (nonatomic, readonly, copy) NSString *gender;
@property (nonatomic, readonly, copy) NSString *avatarUrlSmall;
@property (nonatomic, readonly, copy) NSString *avatarUrlLarge;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

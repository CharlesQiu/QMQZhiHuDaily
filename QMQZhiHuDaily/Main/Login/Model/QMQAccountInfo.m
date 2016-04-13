//
//  QMQAccountInfo.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/12/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQAccountInfo.h"

@interface QMQAccountInfo ()

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *avatarUrlSmall;
@property (nonatomic, copy) NSString *avatarUrlLarge;

@end

@implementation QMQAccountInfo

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.city           = dic[@"city"];
    self.province       = dic[@"province"];
    self.nickName       = dic[@"nickname"];
    self.gender         = dic[@"gender"];
    self.avatarUrlSmall = dic[@"figureurl_qq_1"];
    self.avatarUrlLarge = dic[@"figureurl_qq_2"];
    
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"account.data"];
    [NSKeyedArchiver archiveRootObject:self toFile:file];
    
    return self;
}

/// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.avatarUrlSmall forKey:@"avatarUrlSmall"];
    [aCoder encodeObject:self.avatarUrlLarge forKey:@"avatarUrlLarge"];
}

/// 解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ([super init]) {
        self.city           = [aDecoder decodeObjectForKey:@"city"];
        self.province       = [aDecoder decodeObjectForKey:@"province"];
        self.nickName       = [aDecoder decodeObjectForKey:@"nickName"];
        self.gender         = [aDecoder decodeObjectForKey:@"gender"];
        self.avatarUrlSmall = [aDecoder decodeObjectForKey:@"avatarUrlSmall"];
        self.avatarUrlLarge = [aDecoder decodeObjectForKey:@"avatarUrlLarge"];
    }
    return self;
}

@end

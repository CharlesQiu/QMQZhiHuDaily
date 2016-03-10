//
//  QMQLatestNewsDetailModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/26/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLatestNewsDetailModel.h"

@interface QMQLatestNewsDetailModel ()

@property(nonatomic, copy) NSString *imageUrl;

@end

@implementation QMQLatestNewsDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.imageUrl = dic[@"image"];
    
    return self;
}

@end

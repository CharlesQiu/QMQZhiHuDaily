//
//  QMQLatestNewsModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLatestNewsModel.h"

@interface QMQLatestNewsModel ()

@property(nonatomic, assign) NSInteger newsId;
@property(nonatomic, strong) NSString  *title;
@property(nonatomic, strong) NSString  *imageUrl;

@end

@implementation QMQLatestNewsModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.newsId   = [dic[@"id"] integerValue];
    self.title    = dic[@"title"];
    self.imageUrl = dic[@"images"][0];
    
    return self;
}

@end

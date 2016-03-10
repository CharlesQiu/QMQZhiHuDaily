//
//  QMQHistoryNewsModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/29/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQHistoryNewsModel.h"

@interface QMQHistoryNewsModel ()

@property(nonatomic, copy) NSArray      *imageArr;
@property(nonatomic, assign) NSUInteger newsId;
@property(nonatomic, copy) NSString     *title;

@end

@implementation QMQHistoryNewsModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.imageArr = [dic[@"images"] copy];
    self.newsId   = [dic[@"id"] unsignedIntegerValue];
    self.title    = dic[@"title"];
    
    return self;
}

@end

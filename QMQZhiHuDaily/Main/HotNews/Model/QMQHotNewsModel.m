//
//  QMQHotNewsModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 1/7/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQHotNewsModel.h"

@interface QMQHotNewsModel ()

@property (nonatomic, assign) NSInteger newsId;
@property (nonatomic, copy  ) NSString  *thumbNail;
@property (nonatomic, copy  ) NSString  *title;
@property (nonatomic, copy  ) NSString  *url;

@end

@implementation QMQHotNewsModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.newsId    = [dic[@"news_id"] integerValue];
    self.thumbNail = dic[@"thumbnail"];
    self.title     = dic[@"title"];
    self.url       = dic[@"url"];
    
    return self;
}

@end

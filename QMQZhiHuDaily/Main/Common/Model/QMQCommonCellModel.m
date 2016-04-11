//
//  QMQCommonCellModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQCommonCellModel.h"

@interface QMQCommonCellModel ()

@property(nonatomic, copy) NSArray      *imageArr;
@property(nonatomic, assign) NSUInteger newsId;
@property(nonatomic, copy) NSString     *title;
@property (nonatomic, copy) NSString *date;

@end

@implementation QMQCommonCellModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.imageArr = [dic[@"images"] copy];
    self.newsId   = [dic[@"id"] unsignedIntegerValue];
    self.title    = dic[@"title"];
    
    if (dic[@"date"]) {
        NSDateFormatter *formatter = [NSDateFormatter new];
        NSDateFormatter *newFormat = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyyMMdd"];
        [newFormat setDateFormat:@"yyyy.MM.dd"];
        NSDate *date = [formatter dateFromString:dic[@"date"]];
        self.date = [newFormat stringFromDate:date];
    }
    
    return self;
}

@end

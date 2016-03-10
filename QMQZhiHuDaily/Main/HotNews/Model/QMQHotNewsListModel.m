//
//  QMQHotNewsListModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 1/7/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQHotNewsListModel.h"
#import "QMQHotNewsModel.h"

@interface QMQHotNewsListModel ()

@property(nonatomic, copy) NSArray *recentArray;

@end

@implementation QMQHotNewsListModel

- (QMQHotNewsListModel *)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if (dic[@"recent"]) {
        __block NSMutableArray *tempArray = [NSMutableArray array];
        [dic[@"recent"] enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            [tempArray addObject:[[QMQHotNewsModel alloc] initWithDic:obj]];
        }];
        self.recentArray = [tempArray copy];
    }
    
    return self;
}

@end

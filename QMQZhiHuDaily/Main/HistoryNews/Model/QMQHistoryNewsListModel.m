//
//  QMQHistoryNewsListModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 3/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQHistoryNewsListModel.h"
#import "QMQHistoryNewsModel.h"

@interface QMQHistoryNewsListModel ()

@property (nonatomic, copy) NSArray *modelArray;

@end
@implementation QMQHistoryNewsListModel

- (QMQHistoryNewsListModel *)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSMutableArray *tempArray = [NSMutableArray new];
    for (NSDictionary *dict in dic[@"stories"]) {
        [tempArray addObject:[[QMQHistoryNewsModel alloc] initWithDic:dict]];
    }
    self.modelArray = [tempArray copy];
    
    return self;
}

@end

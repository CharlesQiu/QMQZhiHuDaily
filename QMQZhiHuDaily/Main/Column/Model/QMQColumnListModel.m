//
//  QMQColumnListModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 3/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQColumnListModel.h"
#import "QMQColumnModel.h"

@interface QMQColumnListModel ()

@property (nonatomic, copy) NSArray *modelArray;

@end

@implementation QMQColumnListModel

- (QMQColumnListModel *)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSMutableArray *tempArray   = [NSMutableArray new];
    for (NSDictionary *dict in dic[@"data"]) {
        [tempArray addObject:[[QMQColumnModel alloc] initWithDic:dict]];
    }
    self.modelArray = [tempArray copy];

    return self;
}

@end

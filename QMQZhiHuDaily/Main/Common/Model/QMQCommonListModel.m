//
//  QMQCommonListModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQCommonListModel.h"
#import "QMQCommonCellModel.h"

@interface QMQCommonListModel ()

@property (nonatomic, copy) NSString *timeStamp;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray  *modelArray;

@end
@implementation QMQCommonListModel

- (QMQCommonListModel *)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSMutableArray *tempArray = [NSMutableArray new];
    for (NSDictionary *dict in dic[@"stories"]) {
        [tempArray addObject:[[QMQCommonCellModel alloc] initWithDic:dict]];
    }
    self.modelArray = [tempArray copy];
    
    self.timeStamp = dic[@"timestamp"] ? : nil;
    self.name      = dic[@"name"] ? : nil;
    
    return self;
}

@end
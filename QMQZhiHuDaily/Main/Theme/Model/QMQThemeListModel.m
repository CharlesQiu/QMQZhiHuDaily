//
//  QMQThemeListModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 3/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQThemeListModel.h"
#import "QMQThemeModel.h"

@interface QMQThemeListModel ()

@property (nonatomic, copy) NSArray *modelArray;

@end
@implementation QMQThemeListModel

- (QMQThemeListModel *)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSMutableArray *tempArray   = [NSMutableArray new];
    for (NSDictionary *dict in dic[@"others"]) {
        [tempArray addObject:[[QMQThemeModel alloc] initWithDic:dict]];
    }
    self.modelArray = [tempArray copy];
    
    return self;
}

@end

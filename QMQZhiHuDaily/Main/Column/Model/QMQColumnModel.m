//
//  QMQColumnModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/28/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQColumnModel.h"

@interface QMQColumnModel ()

@property(nonatomic, assign) NSUInteger columnId;
@property(nonatomic, copy) NSString     *name;
@property(nonatomic, copy) NSString     *thumbnail;
@property(nonatomic, copy) NSString     *columnDescription;

@end

@implementation QMQColumnModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.columnId          = [dic[@"id"] unsignedIntegerValue];
    self.name              = dic[@"name"];
    self.thumbnail         = dic[@"thumbnail"];
    self.columnDescription = dic[@"description"];
    
    return self;
}

@end

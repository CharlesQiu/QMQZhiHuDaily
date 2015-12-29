//
//  QMQHttpBaseResponse.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/29/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHttpBaseResponse.h"

@interface QMQHttpBaseResponse()

@property (nonatomic, assign) BOOL         success;
@property (nonatomic, copy  ) NSString     *message;
@property (nonatomic, copy  ) NSDictionary *originalDict;

@end

@implementation QMQHttpBaseResponse

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

@end

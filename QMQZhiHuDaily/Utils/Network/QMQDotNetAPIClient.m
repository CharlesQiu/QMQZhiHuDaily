//
//  QMQDotNetAPIClient.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/16/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQDotNetAPIClient.h"

@implementation QMQDotNetAPIClient

static QMQDotNetAPIClient *_sharedClient = nil;

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[super allocWithZone:NULL] init];
    });
    
    return _sharedClient;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [QMQDotNetAPIClient sharedClient];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [QMQDotNetAPIClient sharedClient];
}

@end

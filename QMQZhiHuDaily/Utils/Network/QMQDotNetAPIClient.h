//
//  QMQDotNetAPIClient.h
//  QMQZhiHuDaily
//
//  Created by Charles on 4/16/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface QMQDotNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

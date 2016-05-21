//
//  QMQHttpBaseService.h
//  QMQZhiHuDaily
//
//  Created by Charles on 12/30/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/// Request success.
typedef void (^requestSuccessBlock)(NSInteger statusCode, id responseObj);
/// Request fail
typedef void (^requestFailureBlock)(NSError *error);

@interface QMQHttpBaseService : NSObject

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(requestSuccessBlock)successBlock
    failure:(requestFailureBlock)failureBlock;

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(requestSuccessBlock)successBlock
     failure:(requestFailureBlock)failureBlock;

+ (void)put:(NSString *)url
     params:(NSDictionary *)params
    success:(requestSuccessBlock)successBlock
    failure:(requestFailureBlock)failureBlock;

+ (void)deleteRequest:(NSString *)url
               params:(NSDictionary *)params
              success:(requestSuccessBlock)successBlock
              failure:(requestFailureBlock)failureBlock;

@end

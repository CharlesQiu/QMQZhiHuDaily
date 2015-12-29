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
typedef void(^requestSuccessBlock)(NSInteger statusCode, id responseObj);
/// Request fail
typedef void(^requestFailureBlock)(NSError *error);

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


//#import <Foundation/Foundation.h>
//#import "AFNetworking.h"

///* 当request成功后的 responseBlock */
//typedef void (^successHandlerBlock)(NSInteger statusCode, id responseObj);
//
///* 请求失败的时候 */
//typedef void (^failureHandlerBlock)(NSError *error);
//
//
//@interface ZMHttpBaseService : NSObject
///**
// *  发送一个GET(post...)请求
// *
// *  @param url     请求路径
// *  @param params  请求参数
// *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
// *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
// */
//+ (void)get:(NSString *)url params:(NSDictionary *)params success:(successHandlerBlock)successHandler failure:(failureHandlerBlock)failureHandler;
//
//+ (void)post:(NSString *)url params:(NSDictionary *)params success:(successHandlerBlock)successHandler failure:(failureHandlerBlock)failureHandler;
//
//+ (void)put:(NSString *)url params:(NSDictionary *)params success:(successHandlerBlock)successHandler failure:(failureHandlerBlock)failureHandler;
//
//+ (void)deleteRequest:(NSString *)url params:(NSDictionary *)params success:(successHandlerBlock)successHandler failure:(failureHandlerBlock)failureHandler;
//
//+ (NSString *)prettyPrintJsonData:(id)jsonData;
//@end

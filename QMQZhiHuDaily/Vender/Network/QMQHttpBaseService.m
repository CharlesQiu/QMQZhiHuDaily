//
//  QMQHttpBaseService.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/30/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHttpBaseService.h"

@implementation QMQHttpBaseService

#pragma mark - Init AFHTTPSessionManager
+ (AFHTTPSessionManager *)getRequestManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    return manager;
}

+ (BOOL)beforeHttpRequest:(AFHTTPSessionManager *)manager {
    __block BOOL isNetworkValid = YES;
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                isNetworkValid = YES;
                break;
                
            default:
                [operationQueue setSuspended:YES];
                isNetworkValid = NO;
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
    return isNetworkValid;
}

#pragma mark - Print debug log
+ (NSString *)formatJsonData:(id)jsonData {
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (void)printHttpWithOperation:(NSURLSessionDataTask *)task
                      response:(id)response
                       manager:(AFHTTPSessionManager *)manager {
    // Request url
    DDLogDebug(@"\n---------\nRequest url:%@\n---------", manager.baseURL);
    
    // Response
    if (response) {
        NSString *jsonStr = [self formatJsonData:response];
        DDLogVerbose(@"\n---------\nResponse:%@\n---------", jsonStr);
    }
    
    // Headers
    NSDictionary *dict = manager.requestSerializer.HTTPRequestHeaders;
    DDLogDebug(@"\n---------\nHeaders:%@\n---------", dict);
}

#pragma mark - Request(get/post/put/delete)
+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(requestSuccessBlock)successBlock
    failure:(requestFailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self getRequestManager];
    if (![self beforeHttpRequest:manager]) {
        !failureBlock ? : failureBlock(nil);
        return;
    }
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self printHttpWithOperation:task response:responseObject manager:manager];
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task;
        !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failureBlock ? : failureBlock(error);
    }];
}

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(requestSuccessBlock)successBlock
     failure:(requestFailureBlock)failureBlock; {
    AFHTTPSessionManager *manager = [self getRequestManager];
    if (![self beforeHttpRequest:manager]) {
        !failureBlock ? : failureBlock(nil);
        return;
    }
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self printHttpWithOperation:task response:responseObject manager:manager];
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task;
        !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failureBlock ? : failureBlock(error);
    }];
}

+ (void)put:(NSString *)url
     params:(NSDictionary *)params
    success:(requestSuccessBlock)successBlock
    failure:(requestFailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self getRequestManager];
    if (![self beforeHttpRequest:manager]) {
        !failureBlock ? : failureBlock(nil);
        return;
    }
    [manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self printHttpWithOperation:task response:responseObject manager:manager];
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task;
        !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failureBlock ? : failureBlock(error);
    }];
}

+ (void)deleteRequest:(NSString *)url
               params:(NSDictionary *)params
              success:(requestSuccessBlock)successBlock
              failure:(requestFailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self getRequestManager];
    if (![self beforeHttpRequest:manager]) {
        !failureBlock ? : failureBlock(nil);
        return;
    }
    
    [manager DELETE:url
         parameters:params
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [self printHttpWithOperation:task response:responseObject manager:manager];
         NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task;
         !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
     }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         !failureBlock ? : failureBlock(error);
     }];
}


@end

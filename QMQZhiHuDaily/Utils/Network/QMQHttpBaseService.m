//
//  QMQHttpBaseService.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/30/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHttpBaseService.h"
#import "QMQDotNetAPIClient.h"

@implementation QMQHttpBaseService

#pragma mark - Init AFHTTPSessionManager
+ (AFHTTPSessionManager *)getRequestManager {
    
    QMQDotNetAPIClient *manager = [QMQDotNetAPIClient sharedClient];
    manager.requestSerializer.timeoutInterval = 10;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
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

+ (void)printUrlResponse:(NSHTTPURLResponse *)urlResponse response:(id)response {
    if ([response isKindOfClass:[NSError class]]) {
        NSError *error = (NSError *)response;
        if (error.userInfo) {
            DDLogError(@"\n++++Network Error++++\nDomain : %@\nError Description : %@\n----Network Error-----\n", error.userInfo[@"NSErrorFailingURLStringKey"], error.userInfo[@"NSLocalizedDescription"]);
        } else {
            DDLogError(@"\n++++Network Error++++\nDomain : %@\nError Description : %@\nError Code : %li\nHeaders : %@\n----Network Error-----\n", urlResponse.URL, error.localizedDescription, (long)error.code, [self formatJsonData:urlResponse.allHeaderFields]);
        }
    } else {
        DDLogVerbose(@"\n++++++++++\nDomain : %@\nHeaders : %@\nSuccess Response : %@\n---------", urlResponse.URL, [self formatJsonData:urlResponse.allHeaderFields], response ? [self formatJsonData:response] : @"No Response");
    }
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
    
    [manager GET:url
      parameters:params
        progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
            [self printUrlResponse:urlResponse response:responseObject];
            !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
            [self printUrlResponse:urlResponse response:error];
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
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        [self printUrlResponse:urlResponse response:responseObject];
        !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        [self printUrlResponse:urlResponse response:error];
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
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        [self printUrlResponse:urlResponse response:responseObject];
        !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        [self printUrlResponse:urlResponse response:error];
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
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                [self printUrlResponse:urlResponse response:responseObject];
                !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
            }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                [self printUrlResponse:urlResponse response:error];
                !failureBlock ? : failureBlock(error);
            }];
}


@end

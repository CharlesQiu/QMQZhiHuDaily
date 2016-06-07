//
//  QMQHttpBaseService.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/30/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHttpBaseService.h"
#import "QMQDotNetAPIClient.h"
#import "QMQSpinner.h"

@implementation QMQHttpBaseService

#pragma mark - Init AFHTTPSessionManager
+ (AFHTTPSessionManager *)getRequestManager {
    
    QMQDotNetAPIClient *manager = [QMQDotNetAPIClient sharedClient];
    manager.requestSerializer.timeoutInterval = 10;
    manager.requestSerializer                 = [AFJSONRequestSerializer serializer];
    return manager;
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
        DDLogVerbose(@"\n++++++++++\nDomain : %@\nHeaders : %@\nSuccess Response : %@\n---------", urlResponse.URL, [self formatJsonData:urlResponse.allHeaderFields], response ? [self formatJsonData : response] : @"No Response");
    }
}

#pragma mark - Request(get/post/put/delete)
+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(requestSuccessBlock)successBlock
    failure:(requestFailureBlock)failureBlock {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    @weakify(self);
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        DDLogInfo(@"网络状态返回: %@", AFStringFromNetworkReachabilityStatus(status));
        
        if (status == AFNetworkReachabilityStatusReachableViaWiFi ||
            status == AFNetworkReachabilityStatusReachableViaWWAN) {
            
            AFHTTPSessionManager *manager = [self getRequestManager];
            [manager GET:url
              parameters:params
                progress:^(NSProgress *_Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                    @strongify(self);
                    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                    [self printUrlResponse:urlResponse response:responseObject];
                    !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
                } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                    @strongify(self);
                    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                    [self printUrlResponse:urlResponse response:error];
                    !failureBlock ? : failureBlock(error);
                }];
            
        } else {
            [QMQSpinner showBriefAlert:@"网络连接失败！"];
            !failureBlock ? : failureBlock(nil);
        }
    }];
}

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(requestSuccessBlock)successBlock
     failure:(requestFailureBlock)failureBlock; {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    @weakify(self);
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        DDLogInfo(@"网络状态返回: %@", AFStringFromNetworkReachabilityStatus(status));
        
        if (status == AFNetworkReachabilityStatusReachableViaWiFi ||
            status == AFNetworkReachabilityStatusReachableViaWWAN) {
            
            AFHTTPSessionManager *manager = [self getRequestManager];
            [manager POST:url parameters:params progress:^(NSProgress *_Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                @strongify(self);
                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                [self printUrlResponse:urlResponse response:responseObject];
                !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
            } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                @strongify(self);
                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                [self printUrlResponse:urlResponse response:error];
                !failureBlock ? : failureBlock(error);
            }];
            
        } else {
            [QMQSpinner showBriefAlert:@"网络连接失败！"];
            !failureBlock ? : failureBlock(nil);
        }
    }];
    
}

+ (void)put:(NSString *)url
     params:(NSDictionary *)params
    success:(requestSuccessBlock)successBlock
    failure:(requestFailureBlock)failureBlock {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    @weakify(self);
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        DDLogInfo(@"网络状态返回: %@", AFStringFromNetworkReachabilityStatus(status));
        
        if (status == AFNetworkReachabilityStatusReachableViaWiFi ||
            status == AFNetworkReachabilityStatusReachableViaWWAN) {
            
            AFHTTPSessionManager *manager = [self getRequestManager];
            [manager PUT:url parameters:params success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                @strongify(self);
                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                [self printUrlResponse:urlResponse response:responseObject];
                !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
            } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                @strongify(self);
                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                [self printUrlResponse:urlResponse response:error];
                !failureBlock ? : failureBlock(error);
            }];
            
        } else {
            [QMQSpinner showBriefAlert:@"网络连接失败！"];
            !failureBlock ? : failureBlock(nil);
        }
    }];
}

+ (void)deleteRequest:(NSString *)url
               params:(NSDictionary *)params
              success:(requestSuccessBlock)successBlock
              failure:(requestFailureBlock)failureBlock {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    @weakify(self);
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        DDLogInfo(@"网络状态返回: %@", AFStringFromNetworkReachabilityStatus(status));
        
        if (status == AFNetworkReachabilityStatusReachableViaWiFi ||
            status == AFNetworkReachabilityStatusReachableViaWWAN) {
            
            AFHTTPSessionManager *manager = [self getRequestManager];
            [manager DELETE:url
                 parameters:params
                    success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                        @strongify(self);
                        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                        [self printUrlResponse:urlResponse response:responseObject];
                        !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
                    }
                    failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                        @strongify(self);
                        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                        [self printUrlResponse:urlResponse response:error];
                        !failureBlock ? : failureBlock(error);
                    }];
            
        } else {
            [QMQSpinner showBriefAlert:@"网络连接失败！"];
            !failureBlock ? : failureBlock(nil);
        }
    }];
}

@end

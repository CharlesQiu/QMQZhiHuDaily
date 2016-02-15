//
//  QMQHttpService.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/30/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHttpService.h"
#import "QMQHttpBaseService.h"

@implementation QMQHttpService

+ (QMQHttpBaseResponse *)operateResponseObj:(id)responseObj error:(NSError *)error statusCode:(NSInteger)statusCode {
    QMQHttpBaseResponse *res = nil;
    if (error) {
        res = [[QMQHttpBaseResponse alloc] init];
        res.success = NO;
    } else {
        res = [[QMQHttpBaseResponse alloc] initWithDic:responseObj];
        res.success = YES;
    }
    res.statusCode = statusCode;
    return res;
}

+ (void)getWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [QMQHttpBaseService get:url params:param success:^(NSInteger statusCode, id responseObj) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([self operateResponseObj:responseObj error:nil statusCode:statusCode]);
    } failure:^(NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([self operateResponseObj:nil error:error statusCode:error.code]);
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [QMQHttpBaseService post:url params:param success:^(NSInteger statusCode, id responseObj) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([self operateResponseObj:responseObj error:nil statusCode:statusCode]);
    } failure:^(NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([self operateResponseObj:nil error:error statusCode:error.code]);
    }];
}

+ (void)putWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [QMQHttpBaseService put:url params:param success:^(NSInteger statusCode, id responseObj) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([self operateResponseObj:responseObj error:nil statusCode:statusCode]);
    } failure:^(NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([self operateResponseObj:nil error:error statusCode:error.code]);
    }];
}

+ (void)deleteWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [QMQHttpBaseService deleteRequest:url params:param success:^(NSInteger statusCode, id responseObj) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([self operateResponseObj:responseObj error:nil statusCode:statusCode]);
    } failure:^(NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([self operateResponseObj:nil error:error statusCode:error.code]);
    }];
}
@end

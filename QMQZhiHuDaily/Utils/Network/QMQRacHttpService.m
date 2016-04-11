//
//  QMQRacHttpService.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/27/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQRacHttpService.h"
#import "QMQHttpBaseService.h"

@implementation QMQRacHttpService

+ (RACSignal *)racGet:(NSString *)url param:(id)param {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [QMQHttpBaseService get:url params:param success:^(NSInteger statusCode, id responseObj) {
            QMQHttpBaseResponse *response = [[QMQHttpBaseResponse alloc] initWithDic:responseObj];
            response.success = YES;
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
}

@end

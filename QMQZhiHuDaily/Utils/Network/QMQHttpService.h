//
//  QMQHttpService.h
//  QMQZhiHuDaily
//
//  Created by Charles on 12/30/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QMQHttpBaseResponse.h"

typedef void (^responseOperator)(QMQHttpBaseResponse *response);

@interface QMQHttpService : NSObject

+ (void)getWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock;

+ (void)postWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock;

+ (void)putWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock;

+ (void)deleteWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock;

@end


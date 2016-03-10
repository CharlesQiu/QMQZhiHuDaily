//
//  QMQRacHttpService.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/27/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQRacHttpService : NSObject

+ (RACSignal *)racGet:(NSString *)url param:(id)param;

@end

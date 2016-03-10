//
//  QMQRacBaseViewModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/28/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQRacBaseViewModel : NSObject

@property (nonatomic) RACSubject *errors;

/// 取消请求Command
@property (nonatomic, strong, readonly) RACCommand *cancelCommand;

@end

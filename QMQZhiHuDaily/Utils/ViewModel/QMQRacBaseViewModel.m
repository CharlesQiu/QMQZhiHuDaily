//
//  QMQRacBaseViewModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/28/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQRacBaseViewModel.h"

@implementation QMQRacBaseViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _errors        = [RACSubject subject];
        _cancelCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal empty];
        }];
    }
    return self;
}

- (void)dealloc {
    [_errors sendCompleted];
}

@end

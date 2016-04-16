//
//  QMQLatesNewsDetailViewModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 3/12/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLatestNewsDetailViewModel.h"
#import "QMQLatestNewsDetailModel.h"

@interface QMQLatestNewsDetailViewModel ()

@property (nonatomic, strong) QMQLatestNewsDetailModel *model;

@end

@implementation QMQLatestNewsDetailViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initCommand];
        [self initSubscriber];
    }
    return self;
}

- (void)initCommand {
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [QMQRacHttpService racGet:API_GET_NEWS_DETAIL((unsigned long)[input unsignedIntegerValue]) param:nil];
    }];
}

- (void)initSubscriber {
    [[_requestCommand.executionSignals switchToLatest] subscribeNext:^(QMQHttpBaseResponse *response) {
        if (response.originalDict) {
            QMQLatestNewsDetailModel *model = [[QMQLatestNewsDetailModel alloc] initWithDic:response.originalDict];
            self.model = model;
        }
    }];
}

@end

//
//  QMQColumnViewModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/29/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQColumnViewModel.h"
#import "QMQColumnListModel.h"

@interface QMQColumnViewModel ()

@property (nonatomic, copy) NSArray *modelArray;

@end

@implementation QMQColumnViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initCommand];
        [self initSubscribe];
    }
    return self;
}

- (void)initCommand {
    _loadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [QMQRacHttpService racGet:API_SECTIONS param:nil];
    }];
}

- (void)initSubscribe {
    @weakify(self);
    [[_loadCommand.executionSignals switchToLatest] subscribeNext:^(QMQHttpBaseResponse *response) {
        @strongify(self);
        if (!response) {
            [self.errors sendNext:response.originalDict];
        } else {
            QMQColumnListModel *model = [[QMQColumnListModel alloc] initWithDic:response.originalDict];
            self.modelArray = [model.modelArray copy];
        }
    }];
}

@end

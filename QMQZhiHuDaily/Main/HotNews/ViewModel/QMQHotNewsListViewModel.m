//
//  QMQHotNewsListViewModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 1/7/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQHotNewsListViewModel.h"
#import "QMQHotNewsListModel.h"

@interface QMQHotNewsListViewModel ()

@property(nonatomic, copy) NSArray *modelArray;

@end

@implementation QMQHotNewsListViewModel

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
        return [QMQRacHttpService racGet:API_HOT_NEWS param:nil];
    }];
}

- (void)initSubscribe {
    @weakify(self);
    [[_loadCommand.executionSignals switchToLatest] subscribeNext:^(QMQHttpBaseResponse *response) {
        @strongify(self);
        if (!response) {
            [self.errors sendNext:response.originalDict];
        } else {
            QMQHotNewsListModel *model = [[QMQHotNewsListModel alloc] initWithDic:response.originalDict];
            self.modelArray = model.recentArray;
        }
    }];
}

@end

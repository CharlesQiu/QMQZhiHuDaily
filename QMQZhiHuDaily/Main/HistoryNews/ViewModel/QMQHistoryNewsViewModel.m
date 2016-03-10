//
//  QMQHistoryNewsViewModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/29/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQHistoryNewsViewModel.h"
#import "QMQHistoryNewsListModel.h"

@interface QMQHistoryNewsViewModel ()

@property (nonatomic, copy) NSArray *modelArray;

@end

@implementation QMQHistoryNewsViewModel

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
        return [QMQRacHttpService racGet:API_BEFORE_NEWS(@"20160229") param:nil];
    }];
}

- (void)initSubscribe {
    @weakify(self);
    [[_loadCommand.executionSignals switchToLatest] subscribeNext:^(QMQHttpBaseResponse *response) {
        @strongify(self);
        if (!response) {
            [self.errors sendNext:response.originalDict];
        } else {
            QMQHistoryNewsListModel *model = [[QMQHistoryNewsListModel alloc] initWithDic:response.originalDict];
            self.modelArray = [model.modelArray copy];
        }
    }];
}

@end
